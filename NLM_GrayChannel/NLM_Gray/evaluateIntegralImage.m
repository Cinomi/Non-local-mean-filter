function [patchSum] = evaluateIntegralImage(ii, row, col, patchSize)
% This function should calculate the sum over the patch centred at row, col
% of size patchSize of the integral image ii

%REPLACE THIS!
patchR = floor(patchSize/2);
l1=ii(row-patchR-1,col-patchR-1);
l2=ii(row-patchR-1,col+patchR);
l3=ii(row+patchR,col+patchR);
l4=ii(row+patchR,col-patchR-1);
patchSum=l3-l2-l4+l1;
end