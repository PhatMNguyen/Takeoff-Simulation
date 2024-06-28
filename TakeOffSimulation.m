
clc
clear all
close all
format shortG

C = Constants; % Load simulation constants

tm = 0:0.1:180; % Modeling time
So = C.AC.S; % Initial aircraft state

Options = odeset('RelTol', 1E-10, 'Events', @(t, S) TakeOffEvent(t, S, C)); % Set numerical integrator accuracy and event function
[t, S] = ode45(@(t, S) TakeOffEom(t, S, C), tm, So, Options); % Integrate aircraft equations of motion

t = transpose(t); % Transpose time vector
S = transpose(S); % Transpose state matrix

P= S(1:3,:); %{km}
v= S(4:6,:);  %{km/s}
W=S(7:9,:);%{rad/s}
E=S(10:12,:);%{rad}
Fuel_Mass=S(13,:); %{kg}

%Plots
PlotMass(t, Fuel_Mass, C); % Plot fuel mass
PlotEulerAngles(t, E); % Plot Euler angles
PlotAngularVelocity(t, W); % Plot rotational velocity
PlotAcceleration(t, S, C); % Plot acceleration
PlotVelocity(t,v); % Plot velocity
PlotPosition(t, P); % Plot position
PlotAltitude(t, P, C); % Plot altitude


