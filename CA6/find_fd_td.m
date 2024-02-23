function [fd, td] = find_fd_td(x_received, fs, fc)
    fourier = fftshift(fft(x_received));
    [~, mx_fourier] = max(abs(fourier));
    fd = abs(mx_fourier - floor(fs / 2) - 1) - fc; 

    phase = angle(fourier);
    td = phase(mx_fourier) / (2 * pi * (fd + fc));
end