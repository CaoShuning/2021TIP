function [L, G] = Para1(SIG)
if SIG <= 1.3
    L = 5;
    G = 0.5;
elseif SIG <= 1.6
    L = 5;
    G = 5;
elseif SIG <=2.1
    L = 5;
    G = 30;
end
end
    