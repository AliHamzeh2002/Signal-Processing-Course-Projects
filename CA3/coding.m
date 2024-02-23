function encoded_img = coding(msg, gray_img, map_set)    
    msg_code = '';
    for i = 1 : length(msg)
        char_code = map_set{2, strcmp(map_set(1, :), msg(i))};
        msg_code = [msg_code, char_code];
    end 
    msg_code = [msg_code];

    [height, width, ~] = size(gray_img);
    
    if length(msg_code) > height * width
        error("size of msg binary code is bigger than pixels of the image.");
    end
    
    encoded_img = gray_img;

    for i = 1 : length(msg_code)
        row = floor((i-1) / width) + 1;
        col = mod((i-1), width) + 1;
        
        pixel = encoded_img(row, col);
        parity = mod(pixel , 2);
        desired_parity = msg_code(i) - '0';
        if parity ~= desired_parity
            encoded_img(row, col) = encoded_img(row, col) + desired_parity - parity;
        end

    end
end