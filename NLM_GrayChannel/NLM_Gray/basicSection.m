%% Some parameters to set - make sure that your code works at image borders!

% Row and column of the pixel for which we wish to find all similar patches 
% NOTE: For this section, we pick only one patch
row = 1;
col = 2;

% Patchsize - make sure your code works for different values
patchSize = 3;

% Search window size - make sure your code works for different values
searchWindowSize = 7;


%% Implementation of work required in your basic section-------------------

% TODO - Load Image
% image = zeros(100, 100);
image = imread('alleyNoisy_sigma20.png');
gray_image = rgb2gray(image);

% TODO - Fill out this function
image_ii = computeIntegralImage(gray_image);

% TODO - Display the normalised Integral Image
normal_den=image_ii(size(image_ii,1),size(image_ii,2));
normal_ii = double(image_ii./normal_den);


% % NOTE: This is for display only, not for template matching yet!
 figure('name', 'Normalised Integral Image');
 imshow(normal_ii);

% TODO - Template matching for naive SSD (i.e. just loop and sum)
tic
[offsetsRows_naive, offsetsCols_naive, distances_naive] = templateMatchingNaive(gray_image, row, col, patchSize, searchWindowSize);
toc
tic
% TODO - Template matching using integral images
[offsetsRows_ii, offsetsCols_ii, distances_ii] = templateMatchingIntegralImage(gray_image, row, col, patchSize, searchWindowSize);
toc
%% Let's print out your results--------------------------------------------

% NOTE: Your results for the naive and the integral image method should be
% the same!
for i=1:length(offsetsRows_naive)
    disp(['offset rows: ', num2str(offsetsRows_naive(i)), '; offset cols: ',...
        num2str(offsetsCols_naive(i)), '; Naive Distance = ', num2str(distances_naive(i),10),...
        '; Integral Im Distance = ', num2str(distances_ii(i),10)]);
end