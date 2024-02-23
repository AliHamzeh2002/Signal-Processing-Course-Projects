function msg = decoding_freq(map_set, coded_msg, rate);
    fs = 100;
    sec = 0;
    binary_msg = '';
    msg = '';
    for i = 1 : fs : length(coded_msg) - 1
         start_index = sec * fs + 1;
         end_index = start_index + fs;  
         slice = coded_msg(start_index : end_index);
         f = -fs/2 : fs/length(slice) : fs/2 - fs/length(coded_msg);
         fourier = fftshift(fft(slice));
         [mx_fourier, mx_freq] = max(abs(fourier));
         mx_freq = abs(mx_freq - floor(fs / 2) - 1);
         for code = 0 : 2 ^ rate - 1
            cur_frequency = floor(49 / (2 ^ rate)) * code  + (49/(2 ^ (rate + 1)));
            
            if abs(mx_freq - cur_frequency) <= (49/(2 ^ (rate + 1)))
                % if rate == 1
                %     fprintf('cur_frequency = %f, mx_freq: %f\n', cur_frequency, mx_freq);
                %     fprintf('code = %s\n', dec2bin(code));
                % end
                bin_code = dec2bin(code);
                extended = strcat(repmat('0', 1, rate - numel(bin_code)), bin_code);
                binary_msg = [binary_msg, extended];
                break;
            end
         end 
         sec = sec + 1;
    end 
    for i = 1 : 5 : length(binary_msg) - 4
         msg = [msg, map_set{1, strcmp(map_set(2, :), binary_msg(i : i + 4))}];
    end
 
 end
