%% 主要参数设置
m1 = 0.27;% 排球的质量
m2 = 3.6; % 鼓的质量
n = 9; % 人数
d1 = 0.21; %排球直径
d2 = 0.4; % 鼓面直径
h1 = 0.22;% 鼓高度
g = 9.7947; % 重力加速度
HH1 = 0.40; % 初始高度
L = 1.7; % 每个人手中的绳长

% 空气阻力参数
c = 0.5;
rho = 1.29;
S = 4 * pi * (d1/2)^2;
k = 1/2 *c*rho * S;
f_air = @(v)1/2 *c*rho * S * v.^2;

%% 碰撞前球的情况讨论
a = @(v)g - f_air(v)/m1;
v = @(t) integral(a,0,t);

%% 碰撞之前鼓的情况讨论
Fi = @(h,F)(HH1 - h)./L * F;
