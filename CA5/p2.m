    map_set = cell(2, 32);

letters = ['a':'z'];
for i = 1:numel(letters)
    binary_string = dec2bin(i-1, 5);
    map_set{1, i} = letters(i);
    map_set{2, i} = binary_string;
end

special_chars = [' ', '!', '.', ',', '"', ';'];
for i = 1:numel(special_chars)
    binary_string = dec2bin(i+25, 5);
    map_set{1, i+26} = special_chars(i);
    map_set{2, i+26} = binary_string;
end

WORD = 'signal';

fs = 100;

figure;
x1 = coding_freq(map_set, WORD, 1);
t1 = 0:1/fs:(length(x1)-1)/fs;
plot(t1, x1);
title('message signal with rate = 1');

figure;
x2 = coding_freq(map_set, WORD, 5);
t2 = 0:1/fs:(length(x2)-1)/fs;
plot(t2, x2);
title('message signal with rate = 5');

msg1 = decoding_freq(map_set, x1, 1);
msg2 = decoding_freq(map_set, x2, 5);
fprintf('message with rate = 1: %s\n', msg1);
fprintf('message with rate = 5: %s\n', msg2);


normal = randn(size(x1));
std = 0.01; 
x1_noise = x1 + std * normal;
x2_noise = x2 + std * normal(1 : length(x2));
msg1 = decoding_freq(map_set, x1_noise, 1);
msg2 = decoding_freq(map_set, x2_noise, 5);
fprintf('message with rate = 1 and noise 0.0001: %s\n', msg1);
fprintf('message with rate = 5 and noise 0.0001: %s\n', msg2);

ITERATION_NUM = 20;
max_noise = zeros(1, 5);
stds = 0 : 0.05 : 3;
error_1_bit = zeros(size(stds));
error_5_bit = zeros(size(stds));
for i = 1 : length(stds)
    std = stds(i);
    for j = 1 : ITERATION_NUM
        normal = randn(size(x1));
        x1_noise = x1 + std * normal;
        x2_noise = x2 + std * normal(1 : length(x2));
        msg1 = decoding_freq(map_set, x1_noise, 1);
        msg2 = decoding_freq(map_set, x2_noise, 5);
        for k = 1 : length(WORD)
            if length(msg1) < k
                error_1_bit(i) = error_1_bit(i) + 1;
            elseif msg1(k) ~= WORD(k)
                error_1_bit(i) = error_1_bit(i) + 1;
            end
            if length(msg2) < k
                error_5_bit(i) = error_5_bit(i) + 1;
            elseif msg2(k) ~= WORD(k)
                error_5_bit(i) = error_5_bit(i) + 1;
            end
        end
        if (strcmp(msg1, WORD)==1)
            max_noise(1) = std;
        end
        if (strcmp(msg2, WORD)==1)
            max_noise(2) = std;
        end

    end
    error_1_bit(i) = error_1_bit(i) / ITERATION_NUM;
    error_5_bit(i) = error_5_bit(i) / ITERATION_NUM;
end
figure;
plot(stds, error_1_bit);
hold on;
plot(stds, error_5_bit);
legend('rate = 1', 'rate = 5');
fprintf('max noise for rate = 1: %d\n', max_noise(1));
fprintf('max noise for rate = 5: %d\n', max_noise(2));



