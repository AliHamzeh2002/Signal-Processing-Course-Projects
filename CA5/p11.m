t_start = -1;
t_end = 1;
fs = 50;
t = t_start : 1/fs : t_end - 1 / fs;
N = length(t);
f = -fs/2 : fs/N : fs/2 - fs/N;

x1 = cos(10 * pi * t);

figure;
subplot(1, 2, 1);
plot(t, x1);
title("cos(10 * pi * t)");
xlim([-0.5, 0.5]);
xlabel("t");
ylabel("x1");


y1 = fftshift(fft(x1));
y1 = y1 / max(abs(y1));
subplot(1, 2, 2);
plot(f, abs(y1));
xlim([-10, 10]);
title("Fourier of cos(10 * pi * t)");
xlabel("frequency");
ylabel("y1");



