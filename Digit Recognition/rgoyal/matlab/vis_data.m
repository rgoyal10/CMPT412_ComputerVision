layers = get_lenet();
load lenet.mat
% load data
% Change the following value to true to load the entire dataset.
fullset = false;
[xtrain, ytrain, xvalidate, yvalidate, xtest, ytest] = load_mnist(fullset);
xtrain = [xtrain, xvalidate];
ytrain = [ytrain, yvalidate];
m_train = size(xtrain, 2);
batch_size = 64;
 
 
layers{1}.batch_size = 1;
img = xtest(:, 1);
img = reshape(img, 28, 28);
imshow(img')
 
%[cp, ~, output] = conv_net_output(params, layers, xtest(:, 1), ytest(:, 1));
output = convnet_forward(params, layers, xtest(:, 1));
output_1 = reshape(output{1}.data, 28, 28);
% Fill in your code here to plot the features.

range = 20;
% for convolution layer
for i = 1:range
    output_2 = reshape(output{2}.data, output{2}.height, output{2}.width,output{2}.channel);
    subplot(4,5,i);
    imshow(transpose(output_2(:,:,i))); 
end
saveas(gcf, '../images/vis_data/layer2.jpg');

%for relu layer
for i = 1: range
    output_3 = reshape(output{3}.data, output{3}.height, output{3}.width,output{3}.channel);
    subplot(4,5,i);
    imshow(transpose(output_3(:,:,i)));
end
saveas(gcf, '../images/vis_data/layer3.jpg');
