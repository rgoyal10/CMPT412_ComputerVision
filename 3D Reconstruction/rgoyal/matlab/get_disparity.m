function dispM = get_disparity(im1, im2, maxDisp, windowSize)
% GET_DISPARITY creates a disparity map from a pair of rectified images im1 and
%   im2, given the maximum disparity MAXDISP and the window size WINDOWSIZE.

mask = ones(windowSize, windowSize);

dist = zeros(size(im1,1),size(im1,2));

all_disp = zeros(size(im1,1),size(im1,2), maxDisp+1);


for d = 0:maxDisp
    num_rows_image1 = size(im1,1);
    num_cols_image1 = size(im1,2);
    
    total_dis = 1: (num_rows_image1 * (num_cols_image1 - d));
    
    dist(total_dis) = (im1(total_dis + num_rows_image1*d) - im2(total_dis)).^2;
    all_disp(:,:,d+1) = conv2(dist,mask,'same');   
end

[~, index] = min(all_disp, [], 3);
dispM = index-1;


