clc;
clearvars;


ts=0.01;
t=0:ts:10;
tlen=length(t);
% x=zeros(1,tlen);
x=zeros(size(t));
N=round(tlen/10);
x(1:N)=1;
x(1:N)=ones(1,N);



y=zeros(1,tlen);
index1=501;
y(index1:index1+N-1)=0.5; % received signal
index2=701;
y(index2:index2+N-1)=0.3; % received multipath



noise=0.5*randn(size(y));
% noise=0;
z=y+noise;
% z=noise;
plot(t,x,'LineWidth',4)
hold on
plot(t,y,'Color','r','LineWidth',3)
plot(t,z,'Color','g','LineWidth',2)
ylim([-1 2])

ro=zeros(1,tlen);
for i=1:tlen-N
    tempp=zeros(1,tlen);
    tempp(i:i+N-1)=1;
    ro(i)=innerproduct(tempp,z);
end

figure
plot(t,ro)

[pks,locs]=findpeaks(abs(ro));

saeed=1;

% [val,pos]=max(ro);
% thr=30;
% if val>thr
%     td=t(pos);
%     C=3e8;
%     R=C*td/2;
%     sprintf('R is %d Km',R)
% else
%     sprintf('error')
% end

