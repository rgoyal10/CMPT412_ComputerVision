%got reference from test_network.m
%% Network defintion
layers = get_lenet();
% load the trained weights
load lenet.mat

% image2
image_path = sprintf('../images/image2.jpg');
image_input = imread(image_path);
image_input = im2double(image_input);
image_input = rgb2gray(image_input);
%image(image_input);

%threshold
level = graythresh(image_input);
BW = imbinarize(image_input,level);

%image(BW)

%finding connected components
CC = bwconncomp(BW);
%CC
% total_components = CC.Connectivity;
% total_components

% labelling the components of image
S = regionprops(CC,'BoundingBox');
S = struct2cell(S);

column = size(S,2);
input = zeros(28*28, column);

for i= 1:column
    cropped = imcrop(image_input,S{1,i});
    % padding 
    row_c = size(cropped,1);
    column_c = size(cropped,1);
    if size(cropped,1) < size (cropped,2)
        pading = floor((column_c - row_c)/2);
    else
        pading = floor((row_c - column_c)/2);
    end
    
    cropped = padarray(cropped, [pading,pading],0, 'both');
    input(:,i) = (imresize(cropped, [28*28,1])).';
    
    
    
end
[~, P] = convnet_forward(params, layers, input(:));
[value, idx] = max(P);
fprintf('The predicted number is: %d.\n', idx-1);






   
    
