function T = Thrust(C)%{kN} Thrust WRT the CG in Body coordinates.
    T = C.AC.Tmax * [1; 0; 0];
end
