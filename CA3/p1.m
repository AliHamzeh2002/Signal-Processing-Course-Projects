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

WIDTH_RESIZE = 800;
HEIGHT_RESIZE = 1000;
IMAGE_PATH = "Nunez.jpg";

img = imread(IMAGE_PATH);
img = imresize(img, [WIDTH_RESIZE HEIGHT_RESIZE]);
gray = rgb2gray(img);

msg = 'nunez nunez nunez;';

encoded_img = coding(msg, gray, map_set);

figure
subplot(1,2,1)
imshow(gray)
title('Original Image')

subplot(1,2,2)
imshow(encoded_img)
title('Encoded Image')

decoded_msg = decoding(encoded_img, map_set);

fprintf("the hidden message is %s\n", decoded_msg);










