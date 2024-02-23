function decoded_msg = decoding(encoded_img, map_set)
    binary_code = '';
    decoded_msg = '';
    [height, width, ~] = size(encoded_img);
    num_of_pixels = width * height;
    
    for i = 1 : num_of_pixels
        row = floor((i - 1) / width) + 1;
        col = mod((i - 1), width) + 1;
        pixel = encoded_img(row, col);
        parity = mod(pixel , 2);
        binary_code = [binary_code, num2str(parity)];
        if length(binary_code) == length(map_set{2, 1})
            decoded_msg = [decoded_msg, map_set{1, strcmp(map_set(2, :), binary_code)}];
            binary_code = '';
            if decoded_msg(end) == ';'
                break;
            end
        end
    end
end