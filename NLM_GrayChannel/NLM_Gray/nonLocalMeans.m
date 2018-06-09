function [result] = nonLocalMeans(image, sigma, h, patchSize, windowSize)

%REPLACE THIS 
[rowNum, colNum, ~]=size(image);
dImg=double(image);

%pad image
windowR=floor(windowSize/2);
patchR=floor(patchSize/2);
extendSize=windowR+patchR;
extendImg=padarray(dImg,[extendSize,extendSize],'symmetric');

%find integral image of the difference
[diff_ii]=getDiffIntegral(extendImg, windowSize);
for indexR=1:rowNum
    for indexC=1:colNum
        %get SSD matrix (windowSize x windowSize)
        movedRow=indexR+extendSize;
        movedCol=indexC+extendSize;    % get the corresponds col and row after expanding
        SSD=getSSDmatrix(movedRow,movedCol,diff_ii,patchSize);
        weight=computeWeighting(SSD, h, sigma, patchSize);  % compute weight for SSD matrix
        window=extendImg(movedRow-windowR:movedRow+windowR,movedCol-windowR:movedCol+windowR);  % get window matrix after exending
        window=reshape(window,[windowSize*windowSize,1]);   % reshape the dimension of window matrix to meet SSD matrix dimension
        result(indexR,indexC)=sum(window.*weight);   % get denoisied pixel
    end 
end
result=uint8(result);
end

%function to get difference integral image
function [diff_ii]= getDiffIntegral(extendImg, windowSize)
    diff_ii=cell(windowSize*windowSize,1);    % declare integral images for possible offsets
    windowR=floor(windowSize/2);
    counter=0;
    for offsetCol=-windowR:windowR
        for offsetRow=-windowR:windowR
            counter=counter+1;
            
            movedImg=imtranslate(extendImg,[-offsetCol,-offsetRow]);    % translate the whole image with current offsets
            diff=extendImg-movedImg;     % get difference image
            diff_ii{counter}=computeIntegralImage(diff.*diff);    % get difference integral image
        end
    end
end

%function to get SSD of window
function [SSD]=getSSDmatrix(movedRow, movedCol, diff_ii, patchSize)
    [patchNum,~]=size(diff_ii);
    SSD=zeros(patchNum,1);     
    counter=0;
    for n=1:patchNum
        counter=counter+1;
        SSD(counter,1)=evaluateIntegralImage(diff_ii{counter},movedRow, movedCol, patchSize);
    end
end