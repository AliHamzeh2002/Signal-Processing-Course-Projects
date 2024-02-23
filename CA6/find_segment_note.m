function x = find_segment_note(segment, notes, fs)
    fourier = fftshift(fft(segment));
    [~, mx_fourier] = max(abs(fourier));
    frequency = abs(mx_fourier * fs/(length(segment)) - floor(fs / 2) - 1);
    note_index = find_closest_frequency(notes, frequency);
    note_name = notes{1, note_index};
    fprintf("Note: %s time: T/%d\n", note_name, fs / (length(segment) * 2));

end

function note_index = find_closest_frequency(notes, frequency)
    note_index = 1;
    min_diff = abs(notes{2, 1} - frequency);
    for i = 2:length(notes)
        diff = abs(notes{2, i} - frequency);
        if diff < min_diff
            min_diff = diff;
            note_index = i;
        end
    end
end

