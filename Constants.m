function C = Constants

    C.T.UTC = [2022, 11, 2, 21, 15, 0]; % Coordinated universal time at takeoff {year, month, day, hour, minute, second}
    C.T.JDo = juliandate(datetime(C.T.UTC)); % Julian date at takeoff {solar days}

    C.E.mu = 398600.44; % Gravitational parameter of the Earth {km^3/s^2}
    C.E.Re = 6378.137; % Mean equatorial radius of the Earth {km}
    C.E.we = 2 * pi / 86164.1; % Rotational speed of the Earth {rad/s}
    C.E.g = 9.81 / 1000; % Mean acceleration due to gravity {km/s^2}

    C.GS.phi = (29 + 57 / 60 + 34.1 / 3600) * pi / 180; % Ground station latitude {rad}
    C.GS.lambda = -(95 + 20 / 60 + 26 / 3600) * pi / 180; % Ground station longitude {rad}
    C.GS.hgs = 0.030; % Ground station altitude above mean equator {km}
    C.GS.Azimuth = -27.4 * pi / 180; % Runway azimuth {rad}
    C.GS.We = C.E.we * [cos(C.GS.phi); 0; -sin(C.GS.phi)]; % Rotational velocity of the Earth in NED coordinates {rad/s}
    C.GS.Rgse = (C.E.Re + C.GS.hgs) * [0; 0; -1]; % Ground station position relative to Earth in NED coordinates {km}
    C.GS.Vgse = cross(C.GS.We, C.GS.Rgse); % Ground station velocity relative to Earth in NED coordinates {km/s}
    C.GS.Agse = cross(C.GS.We, C.GS.Vgse); % Ground station acceleration relative to Earth in NED coordinates {km/s^2}
    C.GS.EcefToNed = Ecef2Ned(C.GS.phi, C.GS.lambda); % Matrix that transforms vectors from ECEF coordinates to NED coordinates
    C.GS.NedToEcef = transpose(C.GS.EcefToNed); % Matrix that transforms vectors from NED coordinates to ECEF coordinates

    C.AC.me = 4470; % Aircraft empty mass {kg}
    C.AC.mf = 2880; % Aircraft fuel mass {kg}
    C.AC.mg = C.AC.me + C.AC.mf; % Aircraft gross mass {kg}
    C.AC.I = [ ...
        10968.565, 0.000, 1762.563; ...
        0.000, 35115.678, 0.000; ...
        1762.563, 0.000, 39589.876] * 1E-6; % Aircraft mass moment of inertial tensor {kg-km^2}
    C.AC.alpha = 15; % Aircraft angle of attack range {deg}
    C.AC.Cdy = 0.037; % Lateral drag coefficient {}
    C.AC.Axz = 24.15 * 1E-6; % Aircraft longitudinal reference area {km^2}
    C.AC.Ay = 11.37 * 1E-6; % Aircraft lateral reference area {km^2}
    C.AC.Tmax = 49.82; % Aircraft maximum thrust {kN}
    C.AC.TSFC = 0.02; % Aircraft thrust specific fuel consumption {kg/kN/s}
    C.AC.Rcpcg = zeros(3,1); % Aircraft center of pressure position relative to CG in Body coordinates {km}
    C.AC.Rcggs = zeros(3,1); % Aircraft position relative to the ground station in NED coordinates {km}
    C.AC.Vcggs = zeros(3,1); % Aircraft velocity relative to the ground station in NED coordinates {km/s}
    C.AC.Wcg = zeros(3,1); % Aircraft rotational velocity relative to CG in Body coordinates {rad/s}
    C.AC.E = [0; 0; C.GS.Azimuth]; % Aircraft Euler angles {rad}
    C.AC.S = [C.AC.Rcggs; C.AC.Vcggs; C.AC.Wcg; C.AC.E; C.AC.mg]; % Aircraft state vector

end
