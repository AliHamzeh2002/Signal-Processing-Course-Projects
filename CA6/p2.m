note_names = {'c', 'c#', 'd', 'd#', 'e', 'f', 'f#', 'g', 'g#', 'a', 'a#', 'b'};
frequencies = [523.25, 554.37, 587.33, 622.25, 659.25, 698.46, 739.99, 783.99, 830.61, 880.00, 932.33, 987.77];

notes = cell(2, length(note_names));

for i = 1:length(note_names)
    notes{1, i} = note_names{i};
    notes{2, i} = frequencies(i);
end

fs = 8000;
T = 0.5;
tau = 0.025;

music_data = {{'d', T/2}, {'d', T/2}, {'g', T}, {'f#', T}, {'d', T},...
        {'d', T/2}, {'e', T/2}, {'e', T/2}, {'d', T/2}, {'f#', T/2}, {'d', T/2}, {'e', T/2}, {'d', T/2}, {'e', T/2}, {'f#', T/2}, {'e', T/2},...
        {'d', T}, {'e', T}, {'f#', T}, {'e', T}, ...
        {'d', T/2}, {'e', T/2}, {'e', T/2}, {'d', T/2}, {'f#', T/2}, {'d', T/2}, {'e', T},...
        {'d', T}, {'e', T/2}, {'d', T/2}, {'f#', T}, {'e', T}, ...
        {'d', T}, {'e', T/2}, {'d', T/2}, {'f#', T}, {'e', T}, ...
        {'d', T/2}, {'d', T/2}, {'e', T}, {'f#', T/2}, {'e', T/2}, {'f#', T}, ...
        {'f#', T/2}, {'e', T/2}, {'f#', T}, {'f#', T}, {'d', T}
};


music = generate_music(notes, music_data, fs, tau);
audiowrite("music_2_1.wav", music, fs);

my_music_data = {
    {'c', T/2}, {'c', T/2}, {'g', T/2}, {'g', T/2}, ...
    {'a', T/2}, {'a', T/2}, {'g', T},...
    {'f', T/2}, {'f', T/2}, {'e', T/2}, {'e', T/2}, ...
    {'d', T/2}, {'d', T/2}, {'c', T}, ...
};

music = generate_music(notes, my_music_data, fs, tau);
audiowrite("music_2_2.wav", music, fs);

[music, fs] = audioread("music_2_1.wav");
music = music';

segments = find_segments(music, fs, tau);

for i = 1 : length(segments)
    segment = segments{i};
    find_segment_note(segment, notes, fs);
end




