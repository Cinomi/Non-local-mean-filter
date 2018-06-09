function [offsetsRows, offsetsCols, distances] = templateMatchingNaive(image, row, col, patchSize, searchWindowSize)
% This function should for each possible offset in the search window
% centred at the current row and col, save a value for the offsets and
% patch distances, e.g. for the offset (-1,-1)
% offsetsRows(1) = -1;
% offsetsCols(1) = -1;
% distances(1) = 0.125;

% The distance is simply the SSD over patches of size patchSize between the
% 'template' patch centred at row and col and a patch shifted by the
% current offset

%REPLACE THIS

    dImg=double(image);

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
    
    %check each offset
    counter=0;
    for offsetRow=-windowR:windowR
        for offsetCol=-windowR:windowR
            counter=counter+1;
            offsetsRows(counter)=offsetRow;
            offsetsCols(counter)=offsetCol;        
            % find corresponded patch and compute SSD
            ssd=0;
            for patchRow=-patchR:patchR
                for patchCol=-patchR:patchR
                    diff = extendImg(movedRow + patchRow, movedCol + patchCol)-extendImg(movedRow + offsetRow + patchRow, movedCol + offsetCol + patchCol);
                    %diff = extendImg(movedRow + patchRow, movedCol + patchCol,:)-extendImg(movedRow + offsetRow + patchRow, movedCol + offsetCol + patchCol,:);
                    ssd=ssd+diff.*diff;   % distance for one channel
                    %ssd=ssd+diff.*diff;
                end
            end
            distances(counter)=ssd;
            %distances(counter)=sum(ssd)/3;
        end
    end
end