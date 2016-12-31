function centerOfMass = centerOfMassCalculator(animatePos_m,joints)
% Calculates center of mass at every timestep given and animatePos_m
massOfCreature = 0;
for ee = 1:length(joints)   
massOfCreature = massOfCreature + joints(ee).mass_M;
end

for ww = 1:length(animatePos_m)
    xCM = 0;
    yCM = 0;
    for uu = 1:length(joints)
        xCM = xCM + animatePos_m(ww,1,uu)*joints(uu).mass_M/massOfCreature;
        yCM = yCM + animatePos_m(ww,2,uu)*joints(uu).mass_M/massOfCreature;
    end
    centerOfMass(ww,1) = xCM;
    centerOfMass(ww,2) = yCM;
end