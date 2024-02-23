function dataset = load_dataset(folder_path)
    file_names = dir(fullfile(folder_path, "*.bmp" ));
    file_names = [file_names; dir(fullfile(folder_path, '*.png'))];
    num_files = length(file_names);

    dataset = cell(num_files, 2);
    for i = 1 : num_files
        image_path = fullfile(folder_path, file_names(i).name);
        image = imread(image_path);
        image = imresize(image, [42, 64]);
        [~, file_name, ~] = fileparts(file_names(i).name);
        dataset{i, 1} = image;
        dataset{i, 2} = file_name;
    end
end