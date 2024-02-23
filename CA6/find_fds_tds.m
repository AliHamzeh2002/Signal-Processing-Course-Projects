function [fds, tds] = find_fds_tds(x_received, fc, fs)
    fourier = fftshift(fft(x_received));
    [pks, locs] = findpeaks(abs(fourier));
    [pks, idx] = sort(pks, 'descend');
    locs = locs(idx);
    fds = zeros(1, 2);
    tds = zeros(1, 2);
    phase = angle(fourier);
    for i = 1:2
        fds(i) = abs(locs(2*i) - fs/2 - 1) - fc;
        tds(i) = abs(phase(locs(2*i))) / (2 * pi * (fds(i) + fc));
    end
end