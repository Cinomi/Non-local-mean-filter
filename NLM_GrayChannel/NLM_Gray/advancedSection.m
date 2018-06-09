%% Some parameters to set - make sure that your code works at image borders!
patchSize = 3;
sigma = [20, 5, 10]; % standard deviation (different for each image!)
h = 0.55; %decay parameter
windowSize = 5;

%TODO - Read an image (note that we provide you with smaller ones for
%debug in the subfolder 'debug' int the 'image' folder);
%Also unless you are feeling adventurous, stick with non-colour
%images for now.
%NOTE: for each image, please also read its CORRESPONDING 'clean' or
%reference image. We will need this later to do some analysis
%NOTE2: the noise level is different for each image (it is 20, 10, and 5 as
%indicated in the image file names)

%REPLACE THIS
%imageNoisy = imread('alleyNoisy_sigma20.png');    % patchSize=4, windowSize=5                                                   
%imageNoisy = imread('townNoisy_sigma5.png');      % patchSize=3, windowSize=7
imageNoisy = imread('treesNoisy_sigma10.png');     % fpatchSize]3, windowSize=5

%imageReference = imread('alleyReference.png');
%imageReference = imread('townReference.png');
imageReference = imread('treesReference.png');

imgNoisy = rgb2gray(imageNoisy);

imgRef = rgb2gray(imageReference);

tic;
%TODO - Implement the non-local means functions
filtered = nonLocalMeans(imgNoisy, sigma(3), h, patchSize, windowSize);
toc

%% Let's show your results!

figure;
diff_image = abs(double(imgNoisy) - double(filtered));
subplot(1,3,1),imshow(imgNoisy),title('Noisy image');
subplot(1,3,2),imshow(filtered),title('NK-Means Denoised Image');
subplot(1,3,3),imshow(diff_image ./ max(max((diff_image)))),title('Difference');

%Print some statistics ((Peak) Signal-To-Noise Ratio)
disp('For Noisy Input');
[peakSNR, SNR] = psnr(imgNoisy, imgRef);
disp(['SNR: ', num2str(SNR, 10), '; PSNR: ', num2str(peakSNR, 10)]);

disp('For Denoised Result');
[peakSNR, SNR] = psnr(filtered, imgRef);
disp(['SNR: ', num2str(SNR, 10), '; PSNR: ', num2str(peakSNR, 10)]);
 
%Feel free (if you like only :)) to use some other metrics (Root
%Mean-Square Error (RMSE), Structural Similarity Index (SSI) etc.)