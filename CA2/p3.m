dataset = load_dataset("./p2/Persian Map Set");
[file, path] = uigetfile({'*.jpg;*.bmp;*.png;*.tif'},'Choose an image');

img = imread([path, file]);


plate_box = detect_plate(img);  
plate = imcrop(img, plate_box);
figure
imshow(plate);

img = plate;

WIDTH_RESIZE = 600;
HEIGHT_RESIZE = 800;
MIN_SEGMENT_SIZE = 1700;
MAX_SEGEMENT_SIZE = 50000;
MIN_CORR = 0.60;

figure
subplot(1,4,1)
imshow(img)

img = imresize(img, [WIDTH_RESIZE HEIGHT_RESIZE]);
subplot(1,4,2)
imshow(img)

gray = rgb2gray(img);
subplot(1,4,3)
imshow(gray)

threshold = graythresh(gray);
binary_img = ~imbinarize(gray, threshold - 0.1);
subplot(1,4,4)
imshow(binary_img);

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

function bounding_box = detect_plate(img)
    RESIZE_WIDTH = 800;
    ERR_MARGIN = 10;
    BLUE2PLATE_RATIO = 14;
    

    template = imread("template_big.png");
    resized_img = imresize(img, [NaN, RESIZE_WIDTH]);
    ratio = size(img, 1) / size(resized_img, 1);
    corr_max = 0;

    for i = 1 : 40
        new_template = imresize(template, [NaN, size(template, 2) - i + 1]);
        [corr_mixB, corr_maxB, bboxB] = template_match(new_template, resized_img);
        if corr_maxB > corr_max
            [corr_mix, corr_max, bbox] = deal(corr_mixB, corr_maxB, bboxB);
        end
    end

    bbox_full = [round((bbox(1) - ERR_MARGIN) * ratio), ...
                round((bbox(2) - ERR_MARGIN) * ratio), ...
                round((bbox(3) + 2 * ERR_MARGIN) * ratio), ...
                round((bbox(4) + 2 * ERR_MARGIN) * ratio)];

    bounding_box = bbox_full;
    bounding_box(3) = BLUE2PLATE_RATIO * bbox(3) * ratio;


end

function [corr_mix, corr_max, bbox] = template_match(template, pic)
    corr_red = normxcorr2(template(:, :, 1), pic(:, :, 1));
    corr_green = normxcorr2(template(:, :, 2), pic(:, :, 2));
    corr_blue = normxcorr2(template(:, :, 3), pic(:, :, 3));
    corr_mix = (corr_red + corr_green + corr_blue ) / 3;

    [corr_max, color_idx] = max(abs(corr_mix(:)));
    [y, x] = ind2sub(size(corr_mix), color_idx(1));
    corr_offset = [x - size(template, 2), y - size(template, 1)];
    bbox = [corr_offset(1), corr_offset(2), size(template, 2), size(template, 1)];
end
