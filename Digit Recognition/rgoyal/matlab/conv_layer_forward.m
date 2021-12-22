function [output] = conv_layer_forward(input, layer, param)
% Conv layer forward
% input: struct with input data
% layer: convolution layer struct
% param: weights for the convolution layer

% output: 

h_in = input.height;
w_in = input.width;
c = input.channel;
batch_size = input.batch_size;
k = layer.k;
pad = layer.pad;
stride = layer.stride;
num = layer.num;
% resolve output shape
h_out = (h_in + 2*pad - k) / stride + 1;
w_out = (w_in + 2*pad - k) / stride + 1;

assert(h_out == floor(h_out), 'h_out is not integer')
assert(w_out == floor(w_out), 'w_out is not integer')
input_n.height = h_in;
input_n.width = w_in;
input_n.channel = c;

%% Fill in the code
% Iterate over the each image in the batch, compute response,
% Fill in the output datastructure with data, and the shape. 

output.height = h_out;
output.width = w_out;
output.batch_size = batch_size;
output.channel = num;

filtered = zeros(h_out*w_out, num);

for i = 1:batch_size
    input_n.data = input.data(:,i);
    temp = im2col_conv(input_n, layer, h_out, w_out);
    temp = reshape(temp,k*k*c, h_out*w_out);
    for j = 1:num
        row_array = zeros(1,h_out * w_out) +1;
        calculated_bias = transpose(param.b(:,j) * row_array);
        filtered(:,j) = transpose(temp) * param.w(:,j) + calculated_bias;
    end
    output.data(:,i) = reshape(filtered, h_out*w_out*num,1);
end



end

