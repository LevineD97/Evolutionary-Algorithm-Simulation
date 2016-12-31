% Create and edit the creature named 'arch'

clear;clc;close all

joints(1).pos_m = [1,0];
joints(2).pos_m = [0,0];
joints(3).pos_m = [1,2];
joints(4).pos_m = [2,3];
joints(5).pos_m = [3,3];
joints(6).pos_m = [4,2];
joints(7).pos_m = [5,0];
joints(8).pos_m = [4,0];
joints(9).pos_m = [3,1];
joints(10).pos_m = [2,1];


limbs(1).connectedJoints = [1,2];
limbs(2).connectedJoints = [2,3];
limbs(3).connectedJoints = [3,4];
limbs(4).connectedJoints = [4,5];
limbs(5).connectedJoints = [5,6];
limbs(6).connectedJoints = [6,7];
limbs(7).connectedJoints = [7,8];
limbs(8).connectedJoints = [8,9];
limbs(9).connectedJoints = [9,10];
limbs(10).connectedJoints = [10,1];
limbs(11).connectedJoints = [1,3];
limbs(12).connectedJoints = [2,10];
limbs(13).connectedJoints = [3,10];
limbs(14).connectedJoints = [4,10];
limbs(15).connectedJoints = [5,10];
limbs(16).connectedJoints = [4,9];
limbs(17).connectedJoints = [9,5];
limbs(18).connectedJoints = [9,6];
limbs(19).connectedJoints = [9,7];
limbs(20).connectedJoints = [6,4];
limbs(21).connectedJoints = [3,6];

for tt = 1:length(joints)
    joints(tt).radius_m = .5;
    joints(tt).pos_m(2) = joints(tt).pos_m(2)+joints(tt).radius_m;
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

save('arch.mat','joints','limbs')