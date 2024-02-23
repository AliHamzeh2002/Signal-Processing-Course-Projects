function [labeled_img, num_labels] = mysegmentation(binary_img)
    num_labels = 0;
    labeled_img = zeros(size(binary_img));
    [rows, cols] = size(binary_img);
    
    for j = 1 : cols
        for i = 1 : rows
            if (binary_img(i, j) == 0 || labeled_img(i, j) ~= 0)
                continue;
            end
            queue = [i, j];
            num_labels = num_labels + 1;
            labeled_img(i, j) = num_labels;
            while size(queue, 1) ~= 0
                current_pixel = queue(1, :);
                queue(1, :) = [];
                for x = -1:1
                    for y = -1:1
                        if (x == 0 && y == 0)
                            continue;
                        end
                        neighbor_pixel = current_pixel + [x, y];
                        if (neighbor_pixel(1) < 1 || neighbor_pixel(1) > rows || neighbor_pixel(2) < 1 || neighbor_pixel(2) > cols)
                            continue;
                        end
                        if (binary_img(neighbor_pixel(1), neighbor_pixel(2)) == 0 || labeled_img(neighbor_pixel(1), neighbor_pixel(2)) ~= 0)
                            continue;
                        end
                        queue = [queue; neighbor_pixel];
                        labeled_img(neighbor_pixel(1), neighbor_pixel(2)) = num_labels;        
                    end
                end
            end
        end
    end
end