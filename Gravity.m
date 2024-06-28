function g = Gravity(R,C)
    r = norm(R);%{km}Range relative to Earth.
    g = -C.E.mu * R / r^3;%{km/s^2}Acceleration due to gravity in NED coordinates.
end