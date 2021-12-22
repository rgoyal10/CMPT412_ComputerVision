function [input_od] = relu_backward(output, input, layer)

% Replace the following line with your implementation.
input_od = zeros(size(input.data));

% f(x) = 0 if x <0; 1 otherwise

input_od = input.data > 0;

input_od = output.diff.*input_od;
end
