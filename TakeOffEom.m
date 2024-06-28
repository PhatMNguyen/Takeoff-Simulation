function dSdt = TakeOffEom(~,S,C)
Rcggs = S(1:3); % {km} Aircraft position relative to ground station in NED coordinates
Vcggs = S(4:6); % {km/s} Aircraft velocity relative to ground station in NED coordinates
Wcg = S(7:9);   % {rad/s} Aircraft rotational velocity relative to CG in Body coordinates
E = S(10:12);   % {rad} Euler angles relative to pilot
m = S(13);      % {kg} Aircraft mass

Rcge = C.GS.Rgse + Rcggs; % {km} Aircraft position relative to Earth in NED coordinates
Vcge = C.GS.Vgse + cross(C.GS.We, Rcggs) + Vcggs; % {km/s} Aircraft velocity relative to Earth in NED coordinates

NedToBody = Ned2Body(Rcge, E, C); % Transformation matrix: NED to Body coordinates
BodyToNed = transpose(NedToBody); % Transformation matrix: Body to NED coordinates

Rcge = NedToBody * Rcge; % {km} Aircraft position relative to Earth in Body coordinates
Vcge = NedToBody * Vcge; % {km/s} Aircraft velocity relative to Earth in Body coordinates
We = NedToBody * C.GS.We; % {rad/s} Earth's rotational velocity relative to Earth in Body coordinates

[Fd, Md] = Drag(Rcge, Vcge, We, C); % {kN, km-kN} Drag force and moment relative to CG in Body coordinates
Ft = Thrust(C); % {kN} Thrust force relative to CG in Body coordinates

F = BodyToNed * (Fd + Ft); % {kN} Total force relative to CG in NED coordinates
M = Md; % {km-kN} Total moment relative to CG in Body coordinates

[Wdot, Edot] = Euler(Wcg, E, M, C); % {rad/s^2, rad/s} Rotational acceleration and Euler angles rate of change

dmdt = -norm(Ft) * C.AC.TSFC; % {kg/s} Mass flow rate

dSdt = zeros(13,1); % State vector derivative
dSdt(1:3) = Vcggs; % {km/s} Aircraft velocity relative to ground station in NED coordinates
dSdt(4:6) = F / m - C.GS.Agse - cross(C.GS.We, cross(C.GS.We, Rcggs)) - 2 * cross(C.GS.We, Vcggs); % {km/s^2} Aircraft acceleration relative to ground station in NED coordinates
dSdt(7:9) = Wdot; % {rad/s^2} Aircraft rotational acceleration relative to CG in Body coordinates
dSdt(10:12) = Edot; % {rad/s^2} Aircraft Euler angles rate of change
dSdt(13) = dmdt; % {kg/s} Aircraft mass flow rate
end
