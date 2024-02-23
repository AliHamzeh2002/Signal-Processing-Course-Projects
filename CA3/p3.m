board = imread('PCB.jpg');
ic = imread('IC.png');

ICrecognition(ic, board);


function ICrecognition(ic, board)
    board_gray = rgb2gray(board);
    ic_gray = rgb2gray(ic);
    
    correlation = normxcorr2_custom(ic_gray, board_gray);
    
    ic_gray_flipped = flipud(fliplr(ic_gray));
    
    correlation_flipped = normxcorr2_custom(ic_gray_flipped, board_gray);
    
    threshold = 0.7;
    
    [ypeak, xpeak] = find(correlation > threshold * max(correlation(:)) | correlation_flipped > threshold * max(correlation_flipped(:)));
    
    figure;
    imshow(board);
    hold on;
    for i = 1:length(xpeak)
        rectangle('Position', [xpeak(i), ypeak(i), size(ic_gray,2), size(ic_gray,1)], 'EdgeColor', 'r', 'LineWidth', 2);
    end
    title('IC Locations on the Board');
    hold off;
    
end

function correlation = normxcorr2_custom(template, search)
    template = normalize_image(template);
    search = normalize_image(search);

    [template_height, template_width] = size(template);
    [search_height, search_width] = size(search);

    correlation = zeros(search_height - template_height + 1, search_width - template_width + 1);

    for i = 1:size(correlation, 1)
        for j = 1:size(correlation, 2)
            region = search(i:i+template_height-1, j:j+template_width-1);

            numerator = sum(sum(template .* region));
            denominator = sqrt(sum(sum(template.^2)) * sum(sum(region.^2)));
            correlation(i, j) = numerator / denominator;
        end
    end
end

function normalized_image = normalize_image(image)
    image = im2double(image);
    mean_value = mean(image(:));
    std_value = std(image(:));

    normalized_image = (image - mean_value) / std_value;
end
