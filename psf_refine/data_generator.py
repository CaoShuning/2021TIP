# !/usr/bin/env python
# -*- coding:utf-8 -*-
#author: Shuning Cao

import glob
import cv2
import numpy as np
from torch.utils.data import Dataset
import scipy.io as sio
import torch
import h5py
import mat4py
import os
import tables
from torch.utils.data import DataLoader

# patch_size, stride = 40, 10
# aug_times = 1
# scales = [1, 0.9, 0.8, 0.7]
batch_size = 4096
# filename = 'D:\\DATA\\traindata710\\traindata625\\estK'
# filename1 = 'D:\\DATA\\traindata710\\traindata625\\label'
# filename = 'traindata719\estK'
# filename1 = 'traindata719\label'
filename = 'D:\\caoshuning\\caoshuning\\train1012\\train\\'



def datagenerator(data_dir = filename,verbose=False):
    # file_list = glob.glob(data_dir+'/*.tif')
    file_list = glob.glob(data_dir+'*.mat')
    samples = []
    labels = []
    for i in range(len(file_list)):
        a = mat4py.loadmat(file_list[i])
        h = np.transpose(np.array(a['x3']))
        k = np.transpose(np.array(a['x4']))
        padding = int((13-h.shape[0])/2)
        samples.append(np.pad(h,(padding,padding),'constant',constant_values = (0,0)))
        labels.append(np.pad(k,(padding,padding),'constant',constant_values = (0,0)))
        # samples.append(np.transpose(np.array(a['x3'],dtype='float32')))
        # labels.append(np.transpose(np.array(a['x4'],dtype='float32')))
        # a = tables.open_file(file_list[i])
        # x3 = a.root.x3[:]
        # x4= a.root.x4[:]
        # samples.append(a.get_node('/'+'x3')[:])#I get too much trouble to process v7.3 mat file,v7 could be use by mat4py but compression
        # labels.append(a.get_node('/'+'x4')[:])
    if verbose:
        print(str(i+1) + '/' + str(len(file_list)) + 'is done')
    samples = np.array(np.transpose(samples), dtype='float32')                ##将图像转化为灰度图后才不报错，mat文件用到python需transpose，dncnn中patch都是一样大，而samples大小不一
    samples = np.expand_dims(samples, axis=3)
    discard_n = len(samples) - len(samples) // batch_size * batch_size  # because of batch namalization
    samples = np.delete(samples, range(discard_n), axis=2)

    labels = np.array(np.transpose(labels), dtype='float32')                ##将图像转化为灰度图后才不报错
    labels = np.expand_dims(labels, axis=3)
    discard_n = len(labels) - len(labels) // batch_size * batch_size  # because of batch namalization
    labels = np.delete(labels, range(discard_n), axis=2)
    print('training data finished')
    return samples, labels

# def datageneratorLABEL(data_dir = filename, data_dir1 = filename1, verbose=False):
#     file_list = glob.glob(data_dir+'/*.tif')
#     kt = cv2.imread(data_dir1, 0)
#     KT= []
#     for i in range(len(file_list)):
#         KT.append(kt)
#     if verbose:
#         print(str(i+1) + '/' + str(len(file_list)) + 'is done')
#     KT = np.array(KT, dtype='uint8')
#     KT = np.expand_dims(KT, axis=3)
#     discard_n = len(KT) - len(KT) // batch_size * batch_size  # because of batch namalization
#     KT = np.delete(KT, range(discard_n), axis=0)
#     print('^_^-training data finished-^_^')
#     return KT




class DATASET(Dataset):
    """Dataset wrapping tensors.
    Arguments:
        xs (Tensor): fake data
    """
    def __init__(self, DATA, LABEL):
        super(DATASET, self).__init__()
        self.DATA = DATA
        self.LABEL = LABEL


    def __getitem__(self, index):
        # if self.batch_x is not None:
        batch_x = self.DATA[index]
        # if self.batch_y is not None:
        batch_y = self.LABEL[index]          #这步没有问题
        return batch_x, batch_y

    def __len__(self):
        return self.DATA.size(0)

class KernelDataset(Dataset):
    """
    root:.mat files root path
    augment:if augment
    """
    def __init__(self, root, augment):
        #this list store all .mat files address
        file_list = np.array(glob.glob(root+'*.mat'))
        self.file_list = file_list
        self.augment = augment

    def __getitem__(self, index):
        #read data and return
        #load .mat file
        MAT = mat4py.loadmat(self.file_list[index])
        samples = np.array(MAT['x3'], dtype='float32')
        samples = np.expand_dims(samples, axis=3)
        # samples = samples.transpose((2, 3, 0, 1))
        lables = np.array(MAT['x4'], dtype='float32')
        lables = np.expand_dims(lables, axis=3)
        # lables = lables.transpose((2, 3, 0, 1))
        return torch.Tensor(samples), torch.Tensor(lables)

    def __len__(self):
        #return numbers of .mat files
        return len(self.file_list)



if __name__ == '__main__':
    use_cuda=1
    # DATA,LABEL = datagenerator(data_dir=filename,verbose=False)
    torch_dataset = KernelDataset(root=filename,augment=False)
    # DATA = DATA.astype('float32')
    # DATA = torch.from_numpy(DATA.transpose((2, 3, 0, 1)))
    # LABEL = LABEL.astype('float32')
    # LABEL = torch.from_numpy(LABEL.transpose((2, 3, 0, 1)))
    # torch_dataset = DATASET(DATA, LABEL)
    DLoader = DataLoader(dataset=torch_dataset, num_workers=4, drop_last=True, batch_size=batch_size, shuffle=True)
    for n_count, batch_yx in enumerate(DLoader):
        if use_cuda:
            batch_x, batch_y = batch_yx[0].cuda(), batch_yx[1].cuda()
        # RS = KT - data
