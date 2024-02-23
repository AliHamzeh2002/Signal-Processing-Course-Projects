function music = generate_music(notes, music_data, fs, tau)
    music_notes = cell(1, length(music_data));
    times = zeros(1, length(music_data));
    for i = 1:length(music_data)
        music_notes{i} = music_data{i}{1};
        times(i) = music_data{i}{2};
    end

    music = zeros(1, (sum(times) + length(times) * tau) * fs);

    for i = 1:length(music_notes)
        t_start = sum(times(1:i-1)) + (i-1) * tau;
        t_end = t_start + times(i);
        music(round(t_start * fs) + 1 : round(t_end * fs)) = generate_note_sound(music_notes(i), notes, fs, t_start, t_end);
    end
end

function x = generate_note_sound(note_name, notes, fs, t_start, t_end)
    note_index = find(strcmp(notes(1, :), note_name));
    f = notes{2, note_index};
    t = t_start : 1/fs : t_end - 1/fs;
    x = sin(2 * pi * f * t);
end