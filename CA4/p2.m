ts = 1e-9;
T = 1e-5;
tau = 1e-6;

t = 0:ts:T;
x_sent = zeros(size(t));
N = round(tau / ts);
x_sent(1:N) = 1;
figure;
plot(t, x_sent, 'LineWidth', 3);
title("The sent wave")
ylabel("x(t)")
xlabel("t (s)")
grid on

figure;
alpha = 0.5;
R = 450;
C = 3e8;
td = 2 * R / C;
td_index = round(td / ts);
x_received = zeros(size(t));
x_received(td_index : td_index + N) = alpha;
plot(t, x_received, 'LineWidth', 3);
title("The received wave")
ylabel("x(t)")
xlabel("t (s)")
grid on

figure;
correlation = conv(x_received, x_sent);
plot(t, correlation(1 : length(t)));
title("Convolution Result")
ylabel("convolution")
xlabel("t (s)")
grid on

[mx_cor, td_derived] = max(correlation);
td_derived = td_derived * ts - tau;
R_derived = C * td_derived / 2;
fprintf("distance is %f\n", R_derived);

figure;
noise_power = 0:0.1:4;
errors = zeros(size(noise_power));
tlen = length(t);
for i = 1 : length(noise_power)
    cur_noise_power = noise_power(i);
    cur_noise = cur_noise_power * randn(1, tlen);
    x_recieved_noise = x_received + cur_noise;
    cor = conv(x_sent, x_recieved_noise);
    [mx_cor, td_derived] = max(cor);
    td_derived = td_derived * ts - tau;
    R_derived = C * td_derived / 2;
    err = abs(R_derived - R);
    errors(i) = err;
end
plot(noise_power, errors)
xlabel("Noise Power")
ylabel("Error (in meters)")
ylim([0, max(errors)])
grid on