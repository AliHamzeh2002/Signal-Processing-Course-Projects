function msg = decoding_amp(map_set, coded_msg, rate);
   FS = 100;
   sec = 0;
   t = 0 : 1/FS : (length(coded_msg)-1)/FS;
   binary_msg = '';
   msg = '';
   for i = 1 : FS : length(coded_msg) - 1
        start_index = sec * FS + 1;
        end_index = start_index + FS;  
        slice = coded_msg(start_index : end_index);
        signal = zeros(1, length(coded_msg));
        signal = 2 * sin(2 * pi * t(start_index : end_index));
        correlation = 0.01 * dot(signal, slice);
        for coeff = 0 : 2 ^ rate - 1
            if abs(correlation - (coeff / (2 ^ rate - 1))) <= 1 / (2 * (2 ^ rate - 1))
                bin_coeff = dec2bin(coeff);
                extended = strcat(repmat('0', 1, rate - numel(bin_coeff)), bin_coeff);
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