t_start = 0;
t_end = 1;
fc = 5;
fs = 100;
C = 3e8;
P = 2 / C;
beta = 0.3;


t = t_start: 1/fs: t_end-1/fs;

alpha1 = 0.5;
R1 = 250 * 1000;
v1 = 180 / 3.6;
fd1 = beta * v1;
td1 =  P * R1;

x_received1 = alpha1 * cos(2 * pi * (fd1 + fc)*(t - td1));

R2 = 200 * 1000;
v2 = 216 / 3.6;
alpha2 = 0.6;
fd2 = beta * v2;
td2 = P * R2;

x_received2 = alpha2 * cos(2 * pi * (fd2 + fc)*(t - td2));

x_received_tot = x_received1 + x_received2;

figure;
plot(t, x_received_tot, 'LineWidth', 3);
title("The received wave")
ylabel("x(t)")
xlabel("t (s)")
grid on

[fds, tds] = find_fds_tds(x_received_tot, fc, fs);
[vs, Rs] = find_vs_Rs(fds, tds, beta);

fprintf("R(1) = %f(km), v(1) = %f(km/h)\n", Rs(1) / 1000, vs(1) * 3.6);
fprintf("R(2) = %f(km), v(2) = %f(km/h)\n", Rs(2) / 1000, vs(2) * 3.6);

