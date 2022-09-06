%% 主要参数设置
global k m1 g HH1 m2 L;
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

Proceed(20,0.01)
%% 碰撞前球的情况讨论
% 注意，以数值向上作为正方向
function v_ball = x2vball(x)
    global k m1 g ;
    v_ball = sqrt(m1*g/k)*sqrt(exp(2*k*x/m1)-1)/(exp(k*x/m1))*-1;
end
%% 碰撞之前鼓的情况讨论
function v_drum = h2vdrum(F,x)
    global HH1 m2 g L;
    v_drum = sqrt(16*F*HH1*x/(L*m2)-8*F*x^2/(L*m2)-2*g*x);
end
%% 碰撞时候的速度变化
function [v11,v22] = Crash(v1,v2)
    global m1 m2;
    v11 = ((m1-m2)*v1+2*m2*v2)/(m1+m2);
    v22 = ((m2-m1)*v2+2*m1*v1)/(m1+m2);
end

%% 最终时刻的小球上升的高度
function H = finalHeight(v1)
    global m1 g k; 
    H =  m1/k*(v1)-m1/k*g*log((g+k/m1*v1)/g);
end
%% 全过程的讨论
function Height = Proceed(F,x)
    %想法： 通过以鼓移动的位移x作为一个自变量。通过人对于时间的控制就能够实现鼓移动x，球下落的距离为剩下的HH1-x；
    %对于每一个x，都对应着一个用力的大小F使得球上弹的距离要大于0.40m
    global HH1
    v_ball = x2vball(HH1-x);
    v_drum = h2vdrum(F,x);
    [v11,~] = Crash(v_ball,v_drum);
    Height = finalHeight(v11);
end