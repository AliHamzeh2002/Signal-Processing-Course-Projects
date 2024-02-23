function x = coding_amp(map_set, msg, rate)
    FS = 100;
    msg_code = '';
    for i = 1 : length(msg)
        char_code = map_set{2, strcmp(map_set(1, :), msg(i))};
        msg_code = [msg_code, char_code];
    end 
    msg_code = [msg_code];
    
    t = 0 : 1 / FS : (length(msg_code) / rate);
    x = zeros(1, length(t));
    sec = 0;
    for i = 1 : rate : length(msg_code)
        if i + rate - 1 > length(msg_code)
            break;
        end
        code = msg_code(i : i + rate - 1);
        code = bin2dec(code);
        coeff = code / (2 ^ rate - 1);
        start_index = sec * FS + 1;
        end_index = start_index + FS;        
        x(start_index : end_index) = coeff * sin(2 * pi * t(start_index : end_index));
        sec = sec + 1;
    end
end
