subplot(1,2,1)
t = 0:0.01:1;
z1 = sin(2*pi*t);
plot(t, z1, '--b')
text(x0(1), y0(1), s(1));
title('Sin')
grid on

subplot(1, 2, 2)
z2 = cos(2*pi*t);
plot(t, z2, 'r')
text(x0(2), y0(2), s(2));
title('Cos')
grid on