function gray_img = mygrayfun(img)
    red_values = img(:, :, 1);
    green_values = img(:, :, 2);
    blue_values = img(:, :, 3);
    gray_img = 0.2989 * red_values + 0.5870 * green_values + 0.1140 * blue_values;
end
