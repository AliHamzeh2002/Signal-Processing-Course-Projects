clc;
clearvars;

t=0:0.1:10;
x=2*t-5;
noise=1.2*randn(size(x));

y=x.^2-3*x+4+noise;

y(20)=y(20)+40;


figure
plot(x,y,'.')
xlabel('x')
ylabel('y')