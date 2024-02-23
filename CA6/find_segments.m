function segments =  find_segments(music, fs, tau)
    zero_segment = zeros(1, round(tau * fs));
    current_note = [];
    segments = cell(1, 0);

    for i = 1 : length(zero_segment) : length(music) - length(zero_segment)
        segment = music(i : i + length(zero_segment) - 1);
        if sum(segment) == 0 
            if length(current_note) > 0
                segments{end + 1} = current_note;
                current_note = [];
            end
            continue;
        end
        current_note = [current_note, segment];
    end

    segments{end + 1} = current_note;

end