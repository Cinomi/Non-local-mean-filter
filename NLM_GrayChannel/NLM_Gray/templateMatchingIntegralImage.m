function [offsetsRows, offsetsCols, distances] = templateMatchingIntegralImage(image,row,col,patchSize,searchWindowSize)
% This function should for each possible offset in the search window
% centred at the current row and col, save a value for the offsets and
% patch distances, e.g. for the offset (-1,-1)
% offsetsX(1) = -1;
% offsetsY(1) = -1;
% distances(1) = 0.125;

% The distance is simply the SSD over patches of size patchSize between the
% 'template' patch centred at row and col and a patch shifted by the
% current offset

% This time, use the integral image method!
% NOTE: Use the 'computeIntegralImage' function developed earlier to
% calculate your integral images
% NOTE: Use the 'evaluateIntegralImage' function to calculate patch sums

%REPLACE THIS

    dImg=double(image);
    [rowNum, colNum]=size(dImg);
    offsetsRows=zeros(searchWindowSize*searchWindowSize,1);
    offsetsCols=zeros(searchWindowSize*searchWindowSize,1);
    distances=zeros(searchWindowSize*searchWindowSize,1);
    %pad image
    windowR=floor(searchWindowSize/2);
    patchR=floor(patchSize/2);
    maxExtendSize=windowR+patchR;
    extendSize=0;
    if row<maxExtendSize || col<maxExtendSize
        extendSize=max(maxExtendSize-row+1, maxExtendSize-col+1);
        extendImg=padarray(dImg, [extendSize,extendSize],'symmetric');
    else
        extendImg=dImg;
    end
    movedRow=row+extendSize;
    movedCol=col+extendSize;
    
    counter=0;
    for offsetRow=-windowR:windowR
        for offsetCol=-windowR:windowR
            counter=counter+1;
            offsetsRows(counter)=offsetRow;
            offsetsCols(counter)=offsetCol;
            
            movedImg=imtranslate(extendImg,[-offsetCol,-offsetRow]);
            diffImg=extendImg-movedImg;
            diffImg=diffImg.*diffImg;
            diffIntegral=computeIntegralImage(diffImg);
            distances(counter)=evaluateIntegralImage(diffIntegral,movedRow,movedCol,patchSize);
        end
    end
end