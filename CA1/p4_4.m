function p4_4(audio, Fs, speed)
    if (speed >= 2 && speed <= 0.5 || speed * 10 ~= round(speed * 10))
        error("speed should be between 0.5 and 2. speed should be multiple of 0.1.");
    end
    new_audio = zeros(1, floor(length(audio) / speed));
    new_audio(1) = audio(1);
    for i = 2 : length(new_audio)
        new_audio(i) = (audio(ceil(i * speed)) + audio(floor(i * speed))) / 2;
    end
    sound(new_audio, Fs);
    
    
end