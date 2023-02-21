% Specify input and output directories
rgbDir = 'data/rgb_images';
depthDir = 'data/depth_images';
outputDir = 'data/denoised_depth_images';

% Get list of RGB and depth image files
rgbFiles = dir(fullfile(rgbDir, '*.jpg'));
depthFiles = dir(fullfile(depthDir, '*.png'));

% Loop through all image files and denoise depth images
for i = 1:numel(rgbFiles)
    % Read in RGB and depth images
    rgbPath = fullfile(rgbDir, rgbFiles(i).name);
    depthPath = fullfile(depthDir, depthFiles(i).name);
    
    rgbImage = imread(rgbPath);
    depthImage = imread(depthPath);
    
    % Apply bilateral filter to denoise depth image
    denoisedDepthImage = bilateral_filter(rgbImage, depthImage);
    
    % Save denoised depth image
    outputFilePath = fullfile(outputDir, depthFiles(i).name);
    imwrite(denoisedDepthImage, outputFilePath);
end
