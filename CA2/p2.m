dataset = load_dataset("./p2/Persian Map Set")
[file, path] = uigetfile({'*.jpg;*.bmp;*.png;*.tif'},'Choose an image');
img = imread([path, file]);

WIDTH_RESIZE = 600;
HEIGHT_RESIZE = 800;
MIN_SEGMENT_SIZE = 1700;
MAX_SEGEMENT_SIZE = 50000;
MIN_CORR = 0.60;

figure
subplot(1,4,1)
imshow(img)
title('Original Image')


img = imresize(img, [WIDTH_RESIZE HEIGHT_RESIZE]);
subplot(1,4,2)
imshow(img)
title('Resized Image')


gray = rgb2gray(img);
subplot(1,4,3)
imshow(gray)
title('Grayscale Image')


threshold = graythresh(gray);
binary_img = ~imbinarize(gray, threshold);
subplot(1,4,4)
imshow(binary_img)
title('Binary Image')


[clean_img, labeled_img, num_clean_labels] = myremovecom(binary_img, MIN_SEGMENT_SIZE, MAX_SEGEMENT_SIZE);

license_plate = '';
dataset_img_size = size(dataset{1, 1});
total_letters = size(dataset, 1);

figure
imshow(clean_img)
title('Segmentation Result')
hold on;

for label = 1 : num_clean_labels
    current_obj = labeled_img == label;
    [rows, cols] = find(current_obj);
    xmin = min(cols);
    xmax = max(cols);
    ymin = min(rows);
    ymax = max(rows);

    cropped_image = clean_img(ymin:ymax, xmin:xmax);
    cropped_image = imresize(cropped_image, dataset_img_size);
    corrs = zeros(1,total_letters);
    for k = 1 : total_letters   
        corrs(k) = corr2(dataset{k, 1}, cropped_image);
    end
    [maxcor, max_pos] = max(corrs);
    if maxcor < MIN_CORR
        continue;
    end
    cur_character = dataset{max_pos, 2};
    license_plate = [license_plate; cur_character];
    rectangle('Position', [xmin, ymin, xmax - xmin, ymax - ymin], 'EdgeColor', 'r', 'LineWidth', 2);
end

file = fopen('output.txt', 'w'); 
fprintf(file, license_plate);
fclose(file);