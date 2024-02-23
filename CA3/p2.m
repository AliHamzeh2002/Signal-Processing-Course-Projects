number = '09308404211';
y = make_phone_number_sound(number);
sound(y, 8000);
[y2, Fs] = audioread('a.wav');

phone_number = decode_sound(y2, Fs);

function phone_number = decode_sound(y, Fs)
    segment_duration = 0.1;
    pause_duration = 0.1;
    
    segment_samples = round(segment_duration * Fs);
    pause_samples = round(pause_duration * Fs);
    
    total_segments = floor(length(y) / (segment_samples + pause_samples));
    
    segmented_audio = cell(total_segments, 1);
    
    for i = 1:total_segments
        start_index = (i - 1) * (segment_samples + pause_samples) + 1;
        end_index = start_index + segment_samples - 1;
        segmented_audio{i} = y(start_index:end_index);
    end
    
    keypad = '1':'9';
    keypad = [keypad, '*', '0', '#'];
    phone_number = '';
    
    for i = 1:length(segmented_audio)
        segment = segmented_audio{i};
        corrs = [];
        for j = 1 : length(keypad)
            number_signal = make_character_sound(keypad(j));
            corr_out = xcorr(segment, number_signal);
            corrs = [corrs, max(abs(corr_out))];
        end      
        [max_value, max_index] = max(corrs);
        phone_number = [phone_number, keypad(max_index)];
    end
end


function output = make_phone_number_sound(number)
    fs = 8000;
    toff = 0.1;
    output = [];
    rest_samples = round(toff * fs) + 1;
    rest_time = zeros(1, rest_samples);
    for i = 1 : length(number)
        y = make_character_sound(number(i));
        segment = [y, rest_time];
        output = [output, segment];
        %sound(y, fs);
        %pause(toff);
    end
   % sound(output, fs);

end

function number_sound = make_character_sound(key)
    fr = [697 770 852 941];
    fc = [1209 1336 1477];
    keypad = '1':'9';
    keypad = [keypad, '*', '0', '#'];
    fs = 8000;
    Ts = 1 / fs;
    Ton = 0.1;
    t = 0:Ts:Ton;
    keypad_index = find(keypad == key);
    row = floor((keypad_index - 1) / length(fc)) + 1;
    col = mod(keypad_index - 1, length(fc)) + 1;    
    y1 = sin(2 * pi * fr(row) * t);
    y2 = sin(2 * pi * fc(col) * t);
    number_sound = (y1 + y2) / 2;
end






