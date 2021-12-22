function [output] = pooling_layer_forward(input, layer)

    h_in = input.height;
    w_in = input.width;
    c = input.channel;
    batch_size = input.batch_size;
    k = layer.k;
    pad = layer.pad;
    stride = layer.stride;
    
    h_out = (h_in + 2*pad - k) / stride + 1;
    w_out = (w_in + 2*pad - k) / stride + 1;
    
    
    output.height = h_out;
    output.width = w_out;
    output.channel = c;
    output.batch_size = batch_size;

    % Replace the following line with your implementation.
    output.data = zeros([h_out * w_out * c, batch_size]);
    temp = zeros([h_out , w_out ,c, batch_size]);
    
    %max pooling
    reshaped_data = reshape(input.data,h_in, w_in, c, batch_size);
    
    for i = 1:batch_size
        for j = 1:c
            for m = 1:h_out
                for n = 1:w_out 
                    region = reshaped_data((m-1)*stride+1:(m-1)*stride+k,(n-1)*stride+1:(n-1)*stride+k,j,i);
                    temp(m,n,j,i) = max(region(:));
                end
            end
        end
    end
    
    output.data = reshape(temp, h_out*w_out*c,batch_size);

end

