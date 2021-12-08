function [ composite_img ] = compositeH( H2to1, template, img )
%COMPOSITE Create a composite image after warping the template image on top
%of the image using the homography

% Note that the homography we compute is from the image to the template;
% x_template = H2to1*x_photo
% For warping the template to the image, we need to invert it.
%H_template_to_img = inv(H2to1);
%% Create mask of same size as template
mask = uint8(zeros(size(template,1),size(template,2),size(template,3)));
%mask = zeros(size(template,1),size(template,2),size(template,3));

%% Warp mask by appropriate homography
%im, H, out_size,fill_value
wrap_mask = warpH(mask, H2to1, size(img),1);

%% Warp template by appropriate homography
wrap_template = warpH(template, H2to1, size(img),0);

%% Use mask to combine the warped template and the image

composite_img = wrap_template+img.*wrap_mask;
end