% input: image -- original image
% output: ii -- computed intergral image
function [ii] = computeIntegralImage(image)
    image=double(image);
    ii= cumsum(cumsum(image,1),2);
%     ii = zeros(size(image)); 
%     s = zeros(size(image));        % cumulative sum (column-wise)
%     [row,col,~]=size(image);
%     s(:,1,:)=image(:,1,:); %three channels
% 
%     for i=1:row
%         for j=1:col
%             if i==1 && j==1       % ii(1,1)=im(1,1)
%                 ii(1,1,:)=image(1,1,:);  % three channels
%             elseif i==1 && j>1    % for the first column, ii(i,j)=s(i,j)
%                   s(i,j,:)=s(i,j-1,:)+image(i,j,:);
%                   ii(i,j,:)=s(i,j,:);
%             elseif j==1           % for the first row except ii(1,1)
%                 ii(i,j,:)=ii(i-1,j,:)+s(i,j,:);
%             else                  % general case
%                 s(i,j,:)=s(i,j-1,:)+image(i,j,:);
%                 ii(i,j,:)=ii(i-1,j,:)+s(i,j,:);
%             end
%         end
%     end
end