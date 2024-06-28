function [Fl,Ml] = Lift(R,V,We,C)
% Calculate true air velocity relative to CG in Body coordinates
Vinf = V - cross(We, R); %{km/s}

% Extract longitudinal true air velocity components
Vxz = [Vinf(1); 0; Vinf(3)]; %{km/s}

% Calculate longitudinal true air speed
vxz = norm(Vxz); %{km/s}

% Calculate angle of attack in degrees
alpha = acosd(Vxz(1) / vxz); %{deg}

% Calculate altitude above mean equator
hcg = norm(R) - C.E.Re; %{km}

% Calculate atmospheric density
[~, ~, rho] = StandardAtmosphere(hcg); %{kg/km^3}

% Determine lift coefficient based on angle of attack
if or(alpha <= -C.AC.alpha, alpha >= C.AC.alpha)
    Cl = 0;  %{Lift coefficient for a stalled aircraft}
else
    Cl = 0.1 * alpha + 0.054;  %{Lift coefficient}
end

% Calculate lift force relative to CG in Body coordinates
Fl = -0.5 * Cl * rho * C.AC.Axz * vxz^2 * [0; 0; 1]; %{kN}

% Calculate moment due to lift relative to CG in Body coordinates
Ml = cross(C.AC.Rcpcg, Fl); %{km-kN}
end
