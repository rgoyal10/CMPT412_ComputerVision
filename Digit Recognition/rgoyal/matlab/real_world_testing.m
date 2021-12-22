

%got reference from test_network.m
%% Network defintion
layers = get_lenet();
% load the trained weights
load lenet.mat

layers{1}.batch_size = 1; 


for total = 1:5
    image_path = sprintf('../images/real_images/real_world%d.jpg',total);
    %reference https://www.mathworks.com/help/matlab/ref/imread.html
    image_input = imread(image_path);
    
    %changing the dimesnions of image from RGB(3) to gray scale 
    if ndims(image_input)==3
        image_input = rgb2gray(image_input);
    end
    image_input = imresize(image_input, [28,28]);
    image_input = double(image_input)/255;
    image_input = reshape(image_input,[],1);
    [~, P] = convnet_forward(params, layers, image_input(:));
    [value, idx] = max(P);
    fprintf('The predicted number is: %d.\n', idx-1);
    
end



