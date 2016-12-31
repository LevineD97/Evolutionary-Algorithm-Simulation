function animatePos_m = physics(environment, joints, limbs, ...
    activationMatrix)
% This function calls and controls the physics_update function, and returns
% a matrix 'animatePos_m' containing the position vectors of all joints
ctr = 1;
animatePos_m = zeros(environment.numTimeSteps, 2, ... 
    length(joints));

environment.time_s = 0;

while ctr <= environment.numTimeSteps
%     This while loop is what controls the physics_update function for
%     every time step
    for yy = 1:length(limbs)
%         Calculates what force the activation matrix will exert on each
%         specified limb
        if activationMatrix(ctr,1,yy)
            limbs(yy).activatedForce_N = environment.activationForce_N;
        else
            limbs(yy).activatedForce_N = 0;
        end
    end
    [joints, limbs] = physics_update(environment,joints,limbs);
    
    environment.time_s = environment.time_s + environment.dt_s;
    for jj = 1:length(joints)
        % Since we found the resultant springforce on each joint, we need
        % to erase those values before starting another update
        joints(jj).springForce_N = [0,0];
        % animatePos_m is a 3 diminesional matrix that stores all of the
        % position data for all joints. This is the output of the function
        animatePos_m(ctr,:,jj) = joints(jj).pos_m;
    end
    ctr = ctr+1;
end



