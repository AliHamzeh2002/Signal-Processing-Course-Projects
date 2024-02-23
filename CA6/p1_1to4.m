t_start = 0;
t_end = 1;
fc = 5;
fs = 100;

t = t_start: 1/fs: t_end-1/fs;
x_sent = cos(2 * pi * fc * t);

figure;
plot(t, x_sent, 'LineWidth', 3);
title("The sent wave")
ylabel("x(t)")
xlabel("t (s)")
grid on

R = 250 * 1000;
v = 180 / 3.6;
beta = 0.3;
alpha = 0.5;

fd = beta * v;
C = 3e8;
P = 2 / C;

td =  P * R;

x_received = alpha * cos(2 * pi * (fd + fc)*(t - td));

figure;
plot(t, x_received, 'LineWidth', 3);
title("The received wave")
ylabel("x(t)")
xlabel("t (s)")
grid on

[fd_derived, td_derived] = find_fd_td(x_received, fs, fc);

[v_derived, R_derived] = find_v_R(fd_derived, td_derived, beta);

fprintf("v derived: %f(km/h) R derived: %f(km)\n ", v_derived * 3.6, R_derived / 1000);

noise = randn(1, length(x_received));
stds = 0 : 0.02 : 2;
error_v = zeros(1, length(stds));
error_R = zeros(1, length(stds));
best_std_R = 0;
best_std_v = 0;
error_threshold = 0.1;


for i = 1 : length(stds)
    std = stds(i);
    x_received = alpha * cos(2 * pi * (fd + fc)*(t - td)) + std * noise;
    [fd_derived, td_derived] = find_fd_td(x_received, fs, fc);
    [v_derived, R_derived] = find_v_R(fd_derived, td_derived, beta);
    if (abs(v_derived - v) < error_threshold * v)
        best_std_v = std;
    end
    if (abs(R_derived - R) < error_threshold * R)
        best_std_R = std;
    end
    error_v(i) = abs(v_derived - v) * 3.6;
    error_R(i) = abs(R_derived - R) / 1000;
end

mean_error_v = sum(error_v) / length(stds);
mean_error_R = sum(error_R) / length(stds);
fprintf("mean error v: %f(km/h) mean error R: %f(km)\n ", mean_error_v, mean_error_R);
fprintf("best std v: %f best std R: %f\n ", best_std_v, best_std_R);

figure;
plot(stds, error_v, 'LineWidth', 2);
hold on
plot(stds, error_R, 'LineWidth', 2);
title("Error vs std")
ylabel("error")
xlabel("std")
legend("error v", "error R")


