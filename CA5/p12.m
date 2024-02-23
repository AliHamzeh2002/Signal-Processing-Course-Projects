t_start = 0;
t_end = 1;
fs = 100;
t = t_start : 1/fs : t_end - 1 / fs;
N = length(t);
f = -fs/2 : fs/N : fs/2 - fs/N;

x1 = cos(30 * pi * t + pi / 4);

figure;
subplot(1, 2, 1);
plot(t, x1);
title("cos(30 * pi * t + t/4)");
xlabel("t");
ylabel("x1");


y1 = fftshift(fft(x1));
y1 = y1 / max(abs(y1));
subplot(1, 2, 2);
plot(f, abs(y1));
%xlim([-20, 20])
title("Fourier of cos(30 * pi * t + pi / 4)");
xlabel("frequency");
ylabel("y1");

figure;
tol = 1e-6; 
y1(abs(y1) < tol) = 0; 
 
theta = angle(y1); 
 
plot(f,theta/pi) 
xlabel('Frequency (Hz)')
ylabel('Phase / \pi')
