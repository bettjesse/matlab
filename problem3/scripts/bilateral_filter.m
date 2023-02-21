function [outputImage] = bilateral_filter(rgbImage, depthImage)
% Apply bilateral filter to denoise depth image
% Inputs:
%   rgbImage: RGB input image
%   depthImage: depth input image
% Outputs:
%   outputImage: denoised depth image

% Set filter parameters
w = 5;      % bilateral filter window size
sigma_d = 2;    % bilateral filter spatial standard deviation
sigma_r = 0.1;  % bilateral filter range standard deviation

% Convert RGB image to LAB color space
labImage = rgb2lab(rgbImage);

% Normalize depth image to range [0,1]
depthImage = double(depthImage) ./ (2^16-1);

% Apply bilateral filter to depth image
outputImage = zeros(size(depthImage));
for i = 1:size(depthImage, 3)
    outputImage(:,:,i) = bfilter2(depthImage(:,:,i), w, [sigma_d sigma_r]);
end

% Rescale output image to original depth range
outputImage = uint16(outputImage * (2^16-1));

% Convert output image to LAB color space
outputLabImage = zeros(size(labImage));
for i = 1:size(labImage, 3)
    outputLabImage(:,:,i) = bfilter2(labImage(:,:,i), w, [sigma_d sigma_r]);
end

% Convert output image back to RGB color space
outputImage = lab2rgb(outputLabImage);

end
