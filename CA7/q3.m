syms y(t)
syms x(t)
sys = tf(1, 1);
Dy = diff(y);

ode = diff(y,t,2) + 3 * diff(y, t, 1) + 2*y == 5 * step(sys);
cond1 = y(0) == 1;
cond2 = Dy(0) == 1;
conds = [cond1 cond2];
ySol(t) = dsolve(ode,conds);
ySol = simplify(ySol)

figure;
ts = 0 : 0.1 : 10;
plot(ts, ySol(ts)); 