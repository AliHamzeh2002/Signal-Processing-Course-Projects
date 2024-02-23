function x = coding_freq(map_set, msg, rate)
    msg_code = '';
    for i = 1 : length(msg)
        char_code = map_set{2, strcmp(map_set(1, :), msg(i))};
        msg_code = [msg_code, char_code];
    end 
    msg_code = [msg_code];

    fs = 100;
    
    t = 0 : 1 / fs : (length(msg_code) / rate);
    x = zeros(1, length(t));
    sec = 0;
    for i = 1 : rate : length(msg_code)
        if i + rate - 1 > length(msg_code)
            break;
        end
        code = msg_code(i : i + rate - 1);
        code = bin2dec(code);
        frequency = floor(49 / (2 ^ rate)) * code + (49/(2 ^ (rate + 1)));

        start_index = sec * fs + 1;
        end_index = start_index + fs;        
        x(start_index : end_index) = sin(2 * pi * frequency * t(start_index : end_index));
        sec = sec + 1;
    end
end