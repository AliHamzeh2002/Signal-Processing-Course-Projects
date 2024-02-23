nums = {};
for i = 1 : 9
    nums{1, size(nums, 2) + 1} = num2str(i);
end
for i = 10 : 20
    nums{1, size(nums, 2) + 1} = num2str(i);
end
for i = 20 : 10 : 90
    nums{1, size(nums, 2) + 1} = num2str(i);
end
voice_names = {'baje', 'o', 'shomare'};
voice_names = [voice_names, nums];
map_set = containers.Map;

for i = 1:numel(voice_names)
    audioFileName = strcat(voice_names(i), '.ogg');
    audioFilePath = fullfile('./bank-voice', audioFileName);
    fprintf("%s\n", audioFilePath{1, 1});
    [audioData, fs] = audioread(audioFilePath{1, 1});
    map_set(voice_names{i}) = audioData;
end

save('map_set_data.mat', 'map_set');
