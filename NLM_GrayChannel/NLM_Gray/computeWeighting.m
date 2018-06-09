function [result] = computeWeighting(d, h, sigma, patchSize)
    %Implement weighting function from the slides
    %Be careful to normalise/scale correctly!
    
    %REPLACE THIS
    %result = 0;
    d = d/(patchSize*patchSize);
    result = exp(- max(d- 2 * (sigma^2), 0)/ h^2);
    result = result/sum(result);   %normalize weighting
end