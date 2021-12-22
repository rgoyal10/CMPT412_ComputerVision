%% Network defintion
layers = get_lenet();

%% Loading data
fullset = false;
[xtrain, ytrain, xvalidate, yvalidate, xtest, ytest] = load_mnist(fullset);

% load the trained weights
load lenet.mat

%% Testing the network
% Modify the code to get the confusion matrix
size_matrix =10;
confusion_matrix = zeros(size_matrix,size_matrix);

for i=1:100: size(xtest, 2)
    [output, P] = convnet_forward(params, layers, xtest(:, i:i+99));
    [value, idx] = max(P); %referred to https://www.mathworks.com/help/matlab/ref/max.html
    
    t_value = ytest(:,i:i+99);
    for j=1:numel(idx)
        row = t_value(j);
        column = idx(j);
        confusion_matrix(row,column) = confusion_matrix(row,column) + 1;
    end
end


disp(confusion_matrix);
%When I ran my test_network, I got this confusion matrix (although it changes everytime we run again). And according to
%this the two most confused pairs are: (2,7) and (4,9)
    %49     0     0     0     0     1     0     1     0     1
    %0    52     0     0     0     0     0     0     0     0
    %0     0    41     0     0     0     0     1     0     0
    %0     0     0    44     0     0     0     0     0     1
    %0     0     0     0    44     0     1     0     0     1
    %0     0     0     2     0    48     0     1     1     0
    %1     0     0     0     0     0    38     0     0     0
    %0     2     1     1     0     0     0    56     0     0
    %0     1     0     1     1     0     2     1    53     1
    %0     0     0     0     1     1     0     1     0    49


% calculating accuracy:
sum_diagonal = sum(diag(confusion_matrix));
accuracy = sum_diagonal / sum(confusion_matrix(:));

