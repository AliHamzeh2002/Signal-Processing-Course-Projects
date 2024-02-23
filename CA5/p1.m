T = 1;
fs = 20;
t = 0 : 1/fs : T - 1 / fs;
f = -10 : 1 : 9;

x1 = exp(1i * 2 * pi * 5 * t) + exp(1i * 2 * pi * 8 * t);
y1 = fftshift(fft(x1));
y1 = y1 / max(abs(y1));

x2 = exp(1i * 2 * pi * 5 * t) + exp(1i * 2 * pi * 5.1 * t);
y2 = fftshift(fft(x2));
y2 = y2 / max(abs(y2));

figure;
subplot(2, 1, 1)
plot(f, abs(y1));
xlim([-10, 10]);
title("5Hz + 8Hz");
xlabel("Frequency (Hz)");
ylabel("Magnitude");

subplot(2, 1, 2)
plot(f, abs(y2));
xlim([-10, 10]);
title("5Hz + 5.1Hz");
xlabel("Frequency (Hz)");
ylabel("Magnitude");



