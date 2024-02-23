function [clean_binary_img, clean_labeled_img, num_clean_labels] = myremovecom(binary_img, min_segment_size, max_segement_size)
    [labeled_img, num_labels] = mysegmentation(binary_img);

    pixel_counts = zeros(num_labels, 1);
    clean_labeled_img = zeros(size(labeled_img));
    for label = 1:num_labels
        pixel_counts(label) = sum(labeled_img(:) == label);
    end

    clean_binary_img = zeros(size(binary_img));
    num_clean_labels = 0;
    for label = 1:num_labels
        if pixel_counts(label) >= min_segment_size && pixel_counts(label) < max_segement_size
            clean_binary_img(labeled_img == label) = 1;
            num_clean_labels = num_clean_labels + 1;
            clean_labeled_img(labeled_img == label) = num_clean_labels;
        end
    end
end