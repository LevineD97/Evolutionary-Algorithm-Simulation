% Create and edit the creature named 'snail'
clear; clc; close all;
joints(1).pos_m = [2,2-1.5];
joints(2).pos_m = [2,4-1.5];
joints(3).pos_m = [4,2-1.5];
joints(4).pos_m = [4,4-1.5];
joints(5).pos_m = [5,4-1.5];
joints(6).pos_m = [1,2-1.5];
joints(7).pos_m = [4,5-1.5];
joints(8).pos_m = [5,5-1.5];
joints(9).pos_m = [0,5-1.5];
joints(10).pos_m = [0,2-1.5];
joints(11).pos_m = [6,2-1.5];


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
limbs(13).connectedJoints = [7,8];
limbs(14).connectedJoints = [4,7];
limbs(15).connectedJoints = [5,8];
limbs(16).connectedJoints = [4,8];
limbs(17).connectedJoints = [5,7];
limbs(18).connectedJoints = [9,10];
limbs(19).connectedJoints = [9,1];
limbs(20).connectedJoints = [9,2];
limbs(21).connectedJoints = [10,6];
limbs(22).connectedJoints = [11,5];
limbs(23).connectedJoints = [11,3];
limbs(24).connectedJoints = [7,2];


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
    limbs(ee).c = 30;
    limbs(ee).activatedForce_N = 0;
end

save('snail.mat','joints','limbs')