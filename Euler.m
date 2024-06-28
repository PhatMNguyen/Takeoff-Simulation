function [Wdot, Edot] = Euler(W, E, M, C)
    % Calculate roll and pitch angles
    Roll = E(1); %{rad} Roll angle
    Pitch = E(2); %{rad} Pitch angle

    % Calculate rotational acceleration
    Wdot = C.AC.I \ (M - cross(W, C.AC.I * W)); %{rad/s^2} Rotational acceleration WRT the CG in Body coordinates

    
    OmegaToEuler = [ ...
        1, sin(Roll) * tan(Pitch), cos(Roll) * tan(Pitch); ...
        0,              cos(Roll),             -sin(Roll); ...
        0, sin(Roll) * sec(Pitch), cos(Roll) * sec(Pitch)]; 
    %Matrix translate Angular velocity (W) WRT Body-CG to Euler Angle rate 

    % Calculate Euler angles rate of change
    Edot = OmegaToEuler * W; %{rad/s} Euler angles rate (roll,pitch,yaw rate) WRT time
end