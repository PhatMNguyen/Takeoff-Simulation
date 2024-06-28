function [Fd,Md] = Drag(R,V,We,C)
Vinf = V - cross(We,R); % True air velocity relative to CG in Body coordinates

    % Longitudinal velocities
    Vxz = [Vinf(1); 0; Vinf(3)]; % Longitudinal true air velocity relative to CG
    vxz = norm(Vxz); % Longitudinal true air speed relative to CG

    % Lateral velocities
    Vy = [0; Vinf(2); 0]; % Lateral true air velocity relative to CG
    vy = norm(Vy); % Lateral true air speed relative to CG

    alpha = acosd(Vxz(1) / vxz); % Angle of attack in radians
    
    hcg = norm(R) - C.E.Re; % Altitude above mean equator in kilometers
    [~,~,rho] = StandardAtmosphere(hcg); % Atmospheric density in kg/km^2

    Cdxz = 3.333E-4 * alpha^2 + 0.111; % Longitudinal drag coefficient

    % Drag forces
    Fdxz = -0.5 * Cdxz * rho * C.AC.Axz * vxz^2 * [1; 0; 0]; % Longitudinal drag force relative to CG
    Fy = -0.5 * C.AC.Cdy * rho * C.AC.Ay * vy^2 * [0; 1; 0]; % Lateral drag force relative to CG
    Fd = Fdxz + Fy; % Total drag force relative to CG

    Md = cross(C.AC.Rcpcg,Fd); % Total moment due to drag relative to CG

end
