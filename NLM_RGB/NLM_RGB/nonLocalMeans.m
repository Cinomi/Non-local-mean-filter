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
[patchNum, diff_ii]=getDiffIntegral(extendImg, windowSize);

for indexR=1:rowNum
    for indexC=1:colNum
        %get SSD matrix (windowSize x windowSize)
        movedRow=indexR+extendSize;     
        movedCol=indexC+extendSize;      % get location of pixel in extended image corresponds to current pixel in original image
        SSD=getSSDmatrix(movedRow,movedCol,diff_ii,patchNum, patchSize);
        weight=computeWeighting(SSD, h, sigma, patchSize);
        window=extendImg(movedRow-windowR:movedRow+windowR,movedCol-windowR:movedCol+windowR,:);
        window=reshape(window,[windowSize*windowSize,3]);    % reshape window to match weights matrix's dimension
        result(indexR,indexC,:)=sum(window.*weight);
    end
end

result=uint8(result);
end

%function to get difference integral image for all possible offsets 
function [counter,diff_ii]= getDiffIntegral(extendImg, windowSize)
    diff_ii=cell(windowSize*windowSize,1);
    windowR=floor(windowSize/2);
    counter=0;
    for offsetCol=-windowR:windowR
        for offsetRow=-windowR:windowR
            counter=counter+1;   
            movedImg=imtranslate(extendImg,[-offsetCol,-offsetRow]);
            diff_ii{counter}=computeIntegralImage((extendImg-movedImg).^2);   %compute difference integral image
        end
    end
end

%function to get SSD of window
function [SSD]=getSSDmatrix(movedRow, movedCol, diff_ii, patchNum, patchSize)
    %[patchNum,~]=size(diff_ii);
    SSD=zeros(patchNum,1);
    counter=0;
    for n=1:patchNum
        counter=counter+1;
        SSD(counter)=evaluateIntegralImage(diff_ii{counter},movedRow, movedCol, patchSize);
    end
    % compute SSD for each patch in one window and store them as a
    % (patchNum x 1) matrix
end