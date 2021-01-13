import argparse
import os, time, datetime
# import PIL.Image as Image
import numpy as np
import torch.nn as nn
import torch.nn.init as init
import torch
from skimage.measure import compare_psnr, compare_ssim
from skimage.io import imread, imsave
import mat4py
import scipy.io
import cv2
# os.environ["CUDA_VISIBLE_DEVICES"] = "3"
#
def parse_args():
    parser = argparse.ArgumentParser()
    # parser.add_argument('--set_dir', default='C:\\Users\\caoshuning\\Desktop\\Submit_text\\result\\simulation\\Proposed\\h\\', type=str, help='directory of test dataset')
    parser.add_argument('--set_dir', default='C:\\Users\\caoshuning\\Desktop\\Submit_text\\result\\real\\Proposed\\13-Jan-2021\\h\\', type=str, help='directory of test dataset')
    # parser.add_argument('--label_dir', default='C:\\Users\\caoshuning\\Desktop\\caoshuning\\caoshuning\\Kernel_modify\\testdata723\\label', type=str, help='directory of label')
    # parser.add_argument('--set_names', default=['Set68', 'Set12'], help='directory of test dataset')
    # parser.add_argument('--sigma', default=25, type=int, help='noise level')
    parser.add_argument('--model_dir', default='D:\\caoshuning\\caoshuning\\Kernel_modify\\model\\DnCNN729\\', help='directory of the model')
    # parser.add_argument('--model_dir', default='D:\\caoshuning\\code_DestripeDeblur\\psf_refine\\model\\DnCNN200929\\', help='directory of the model')
    parser.add_argument('--model_name', default='model_1000.pth', type=str, help='the model name')
    # parser.add_argument('--result_dir', default='C:\\Users\\caoshuning\\Desktop\\Submit_text\\result\\simulation\\Proposed\\h_refine\\', type=str, help='directory of test dataset')
    parser.add_argument('--result_dir', default='C:\\Users\\caoshuning\\Desktop\\Submit_text\\result\\real\\Proposed\\13-Jan-2021\\h_refine\\', type=str, help='directory of test dataset')
    parser.add_argument('--save_result', default=1, type=int, help='save the modified kernel, 1 or 0')
    return parser.parse_args()


def log(*args, **kwargs):
     print(datetime.datetime.now().strftime("%Y-%m-%d %H:%M:%S:"), *args, **kwargs)


def save_result(result, path):
    # path = path if path.find('.') != -1 else path+'.tif'
    path + '.tif'
    ext = os.path.splitext(path)[-1]
    if ext in ('.txt', '.dlm'):
        np.savetxt(path, result, fmt='%2.4f')
    else:
        # imsave(path, np.clip(result, 0, 1))
        imsave(path, np.clip(result, 0, 1))


def show(x, title=None, cbar=False, figsize=None):
    import matplotlib.pyplot as plt
    plt.figure(figsize=figsize)
    plt.imshow(x, interpolation='nearest', cmap='gray')
    if title:
        plt.title(title)
    if cbar:
        plt.colorbar()
    plt.show()


class DnCNN(nn.Module):

    def __init__(self, depth=17, n_channels=64, image_channels=1, use_bnorm=True, kernel_size=3):
        super(DnCNN, self).__init__()
        kernel_size = 3
        padding = 1
        layers = []
        layers.append(nn.Conv2d(in_channels=image_channels, out_channels=n_channels, kernel_size=kernel_size, padding=padding, bias=True))
        layers.append(nn.ReLU(inplace=True))
        for _ in range(depth-2):
            layers.append(nn.Conv2d(in_channels=n_channels, out_channels=n_channels, kernel_size=kernel_size, padding=padding, bias=False))
            layers.append(nn.BatchNorm2d(n_channels, eps=0.0001, momentum=0.95))
            layers.append(nn.ReLU(inplace=True))
        layers.append(nn.Conv2d(in_channels=n_channels, out_channels=image_channels, kernel_size=kernel_size, padding=padding, bias=False))
        self.dncnn = nn.Sequential(*layers)
        self._initialize_weights()

    def forward(self, x):
        y = x
        out = self.dncnn(x)
        return y-out

    def _initialize_weights(self):
        for m in self.modules():
            if isinstance(m, nn.Conv2d):
                init.orthogonal_(m.weight)
                print('init weight')
                if m.bias is not None:
                    init.constant_(m.bias, 0)
            elif isinstance(m, nn.BatchNorm2d):
                init.constant_(m.weight, 1)
                init.constant_(m.bias, 0)


if __name__ == '__main__':

    args = parse_args()

    # model = DnCNN()
    # if not os.path.exists(os.path.join(args.model_dir, args.model_name)):
    #
    #     model = torch.load(os.path.join(args.model_dir, 'model.pth'))
    #     # load weights into new model
    #     log('load trained model on train dataset')
    # else:
        # model.load_state_dict(torch.load(os.path.join(args.model_dir, args.model_name)))
    # model = torch.load(os.path.join(args.model_dir, args.model_name))
    model = torch.load(os.path.join(args.model_dir,args.model_name), map_location='cpu')
    log('load trained model')

#    params = model.state_dict()
#    print(params.values())
#    print(params.keys())
#
#    for key, value in params.items():
#        print(key)    # parameter name
#    print(params['dncnn.12.running_mean'])
#    print(model.state_dict())

    model.eval()  # evaluation mode
#    model.train()

    if torch.cuda.is_available():
        model = model.cuda()

    if not os.path.exists(args.result_dir):
        os.mkdir(args.result_dir)

    # for set_cur in args.set_names:


# for set_cur in args.set_names:

    # if not os.path.exists(os.path.join(args.result_dir, set_cur)):
    #     os.mkdir(os.path.join(args.result_dir, set_cur))
    psnrs = []
    ssims = []
    psnrs_bad = []
    for im in os.listdir(args.set_dir):
        if im.endswith(".mat") or im.endswith(".bmp") or im.endswith(".png"):
            # img = mat4py.loadmat(os.path.join(args.set_dir, im))
            img = scipy.io.loadmat(os.path.join(args.set_dir, im))
            # np.random.seed(seed=0)  # for reproducibility
            # x = np.array(imread(os.path.join(args.label_dir, im)), dtype=np.float32) / 255.0
            # y = np.array(imread(os.path.join(args.set_dir, im)), dtype=np.float32) / 255.0  #y is bad kernel

            y = np.array(np.transpose(img['h']), dtype=np.float32)      #for mat file
            y = y.astype(np.float32)
            y_ = torch.from_numpy(y).view(1, -1, y.shape[0], y.shape[1])

            # torch.cuda.synchronize()
            # torch.cuda.synchronize()
            start_time = time.time()
            y_ = y_.cuda()
            x_ = model(y_)  # inference
            x_ = x_.view(y.shape[0], y.shape[1])
            x_ = x_.cpu()
            x_ = x_.detach().numpy().astype(np.float32)
            img['h_refine'] = x_.tolist()

            # torch.cuda.synchronize()
            elapsed_time = time.time() - start_time
            print('%10s : %10s : %2.4f second' % (args.set_dir, im, elapsed_time))

            if args.save_result:
                name, ext = os.path.splitext(im)
                # show(np.hstack((y, x_)))  # show the image
                # mat4py.savemat(filename=os.path.join(args.result_dir, name + '_dncnn' + '.mat'), data=img)
                scipy.io.savemat(os.path.join(args.result_dir, name + '_dncnn' + '.mat'), img)
                # save_result(x_, path=os.path.join(args.result_dir, name + '_dncnn' + '.png'))  # save the denoised image

