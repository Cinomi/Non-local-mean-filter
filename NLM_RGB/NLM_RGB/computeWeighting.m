function [result] = computeWeighting(d, h, sigma, patchSize)
    %Implement weighting function from the slides
    %Be careful to normalise/scale correctly!
    
    %REPLACE THIS
    d = d/(patchSize*patchSize);
    result1 = exp(- max(d - 2 * (sigma^2), 0)/ h^2);
    result1=result1./sum(result1);     %normalize weighting
    result2=cat(2,result1,result1);
    result=cat(2,result2,result1);     % as result1 is a (patchNum x 1) matrix and window is a (patchNum x 3) matrix
                                       % in order to match the dimension, duplicate and connect result1 
end