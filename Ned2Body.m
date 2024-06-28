function NedToBody  = Ned2Body(R,E,C)
R = C.GS.NedToEcef * R;% Aircraft position relative to Earth in ECEF coordinates

x = R(1);% Aircraft x-displacement relative to Earth in ECEF coordinates
y = R(2);% Aircraft y-displacement relative to Earth in ECEF coordinates
z = R(3);% Aircraft z-displacement relative to Earth in ECEF coordinates


r = norm(R);% Aircraft range from Earth center
phi = asin(z / r);% Aircraft latitude
lambda = atan2(y, x);% Aircraft longitude

EcefToLh = Ecef2LH(phi, lambda);% Transformation matrix from ECEF to local horizontal (LH) coordinates

LhToBody = LH2Body(E);% Transformation matrix from LH to Body coordinates

NedToBody = LhToBody * EcefToLh * C.GS.NedToEcef;
end
