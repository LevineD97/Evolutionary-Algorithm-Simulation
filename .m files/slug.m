% Create and edit the creature named 'slug'
clear;clc;close all
joints(1).pos_m = [2,2-1.5];
joints(2).pos_m = [2,4-1.5];
joints(3).pos_m = [4,2-1.5];
joints(4).pos_m = [4,4-1.5];
joints(5).pos_m = [5,4-1.5];
joints(6).pos_m = [1,2-1.5];

limbs(1).connectedJoints = [1,2];
limbs(2).connectedJoints = [1,3];
limbs(3).connectedJoints = [2,4];
limbs(4).connectedJoints = [3,4];
limbs(5).connectedJoints = [1,4];
limbs(6).connectedJoints = [2,3];
limbs(7).connectedJoints = [6,1];
limbs(8).connectedJoints = [6,2];
limbs(9).connectedJoints = [5,4];
limbs(10).connectedJoints = [5,3];
limbs(11).connectedJoints = [2,4];
limbs(12).connectedJoints = [1,3];

for tt = 1:length(joints)
    joints(tt).radius_m = .5;
    joints(tt).mass_M = 1;
    joints(tt).vel_mps = [0,0];
    joints(tt).accel_mpsps = [0,0];
    joints(tt).springForce_N = [0,0];
    joints(tt).force_N = [0,0];
end

for ee = 1:length(limbs)
    limbs(ee).restLength_m = sqrt(sum((joints(limbs(ee).connectedJoints(1)).pos_m ...
    - joints(limbs(ee).connectedJoints(2)).pos_m).^2));
    limbs(ee).separation_m = [0,0];
    limbs(ee).force_N = [0,0];
    limbs(ee).separationLength_m = 0;
    limbs(ee).k_Npm = 200;
    limbs(ee).c = 50;
    limbs(ee).activatedForce_N = 0;
end

save('slug.mat','joints','limbs')