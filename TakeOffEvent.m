function [Value,Isterminal,Direction] = TakeOffEvent(~,S,C) 
% Event function usually requires time and state vector as input, 
% if the event function doesn't depend on time use ~ as place holder for time input later

Rcggs = S(1:3); % {km} Position relative to the ground station in NED coordinates
Vcggs = S(4:6); % {km/s} Velocity relative to the ground station in NED coordinates
E = S(10:12);   % {rad} Euler angles
m = S(13);      % {kg} Mass

Rcge = C.GS.Rgse + Rcggs; % {km} Position relative to the Earth in NED coordinates
Vcge = C.GS.Vgse + cross(C.GS.We, Rcggs) + Vcggs; % {km/s} Velocity relative to the Earth in NED coordinates

NedToBody = Ned2Body(Rcge, E, C); % Transform matrix from NED to Body coordinates
R = NedToBody * Rcge;  % {km} Position in Body coordinates
V = NedToBody * Vcge;  % {km/s} Velocity in Body coordinates
We = NedToBody * C.GS.We; % {rad/s} Earth's rotational velocity in Body coordinates

[Fl, ~] = Lift(R, V, We, C); % {kN} Lift force in Body coordinates
g = Gravity(Rcge, C); % {km/s^2} Gravity acceleration in NED coordinates

Value = norm(Fl) - m * norm(g); % The event condition Lift minus weight
% Meaning the solver looks for lift = weight

Isterminal = 1; % End integration when lift = weight
%If isterminal is set to 1, the integration will stop when the event condition 
%If isterminal is set to 0, the integration will continue even if the event condition is met

Direction = 0; 
% = 0: Detect zero crossings in any direction (from positive or negative to zero).
% = 1: Detect zero crossings only from positive to negative.
% = -1: Detect zero crossings only from negative to positive.
end
%===================================================================================================