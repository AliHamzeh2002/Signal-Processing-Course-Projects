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

FS = 1000;

figure;
x1 = coding_amp(map_set, 'signal', 1);
t1 = 0:1/FS:(length(x1)-1)/FS;
plot(t1, x1);
title('message signal with rate = 1');

figure;
x2 = coding_amp(map_set, 'signal', 2);
t2 = 0:1/FS:(length(x2)-1)/FS;
plot(t2, x2);
title('message signal with rate = 2');

figure;
x3 = coding_amp(map_set, 'signal', 3);
t3 = 0:1/FS:(length(x3)-1)/FS;
plot(t3, x3);
title('message signal with rate = 3');



msg1 = decoding_amp(map_set, x1, 1);
fprintf('message with rate = 1: %s\n', msg1);
msg2 = decoding_amp(map_set, x2, 2);
fprintf('message with rate = 2: %s\n', msg2);
msg3 = decoding_amp(map_set, x3, 3);
fprintf('message with rate = 3: %s\n', msg3);

normal = randn(1, 3001);
var_normal = var(normal);
mean_normal = mean(normal);
fprintf("variance: %f, mean: %f", var_normal, mean_normal);
figure;
histogram(normal);
title('randn distribution');

std = 0.01;

max_noise(3) = zeros(1, 3)
for std = 0.01 : 0.01 : 1
    x1_noise = x1 + std * normal;
    x2_noise = x2 + std * normal(1 : length(x2));
    x3_noise = x3 + std * normal(1 : length(x3));
    msg1 = decoding_amp(map_set, x1_noise, 1);
    msg2 = decoding_amp(map_set, x2_noise, 2);
    msg3 = decoding_amp(map_set, x3_noise, 3);
    if (strcmp(msg1, 'signal'))
        max_noise(1) = std;
    end
    if (strcmp(msg2, 'signal'))
        max_noise(2) = std;
    end
    if (strcmp(msg3, 'signal'))
        max_noise(3) = std;
    end
end
fprintf('max noise for rate = 1: %f\n', max_noise(1));
fprintf('max noise for rate = 2: %f\n', max_noise(2));
fprintf('max noise for rate = 3: %f\n', max_noise(3));






