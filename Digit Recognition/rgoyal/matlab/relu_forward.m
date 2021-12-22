function [output] = relu_forward(input)
output.height = input.height;
output.width = input.width;
output.channel = input.channel;
output.batch_size = input.batch_size;

% f(x) = max(x,0)
% Replace the following line with your implementation.
output.data = zeros(size(input.data));
output.data = max(input.data,0);
end