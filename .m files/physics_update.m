function  [joints,limbs] = physics_update(environment,joints,limbs)
% Uses Velocity Verlet integration to update the physics at each timestep
% environment.dt_s. It does this by using the following steps:

%  1. It calculates the force exterted by each limb on each joint, then
%     finds the resultant of said forces on each joint with vector addition
%  2. It finds the resultant spring forces created by each limb on each
%     joint
%  3. It finds collisons and applies and neccessary changes in momenta, as
%     well as introduces a kind of pseudo-friction that's based on velocity
%  4. It divides the resultant forces on each joint by each respective
%     joint's mass to find acceleration.
%  5. It integrates using the Velocity Verlet Method
%  6. At various points it limits potentially non-physical solutions by
%     setting a max velocity and maximum force
forceFric_N = [0,0];
%     Limb Calculations
for kk = 1:length(limbs)
    %     Calculates the vertical and horizontal separation of each limb
    limbs(kk).separation_m = joints(limbs(kk).connectedJoints(1)).pos_m - ...
        joints(limbs(kk).connectedJoints(2)).pos_m;
    %     Finds the magnitude of the separation
    limbs(kk).separationLength_m = sqrt(limbs(kk).separation_m(1)^2 + ...
        limbs(kk).separation_m(2)^2);
    
    %     Creates a unit vector along which the force will act and applies
    %     the resultant force in that direction. The resultant spring force
    %     is calculated using the equation F = k*x - c*v, where k is the
    %     spring constant and c is the damping constant. The v in our case
    %     is a little tricky to calculate, since it is the projection of
    %     the net velocity of the two connected joints onto the unit vector
    %     of separation.
    
    limbUnitVector_m = limbs(kk).separation_m / ...
        sqrt(sum(limbs(kk).separation_m.^2));
%     Using the dot product to calculate the projection of limbVel_mps on
%     limbUnitVector_m. 
    limbVel_mps = dot((joints(limbs(kk).connectedJoints(1)).vel_mps - ...
        joints(limbs(kk).connectedJoints(2)).vel_mps),limbUnitVector_m);
    
    limbs(kk).force_N = (limbs(kk).k_Npm*(limbs(kk).restLength_m - ...
        limbs(kk).separationLength_m)*limbUnitVector_m) ...
        -limbs(kk).c*limbVel_mps*limbUnitVector_m - ...
        limbs(kk).activatedForce_N*limbUnitVector_m;
    
    %     Since we need to find the net force exerted by each limb on each
    %     joint, the newly calculated spring forces are added to any spring
    %     forces that might already have been calculated. The spring force
    %     is then applied in opposite directions on each joint, since we
    %     need the reaction forces to be equal.
    
    joints(limbs(kk).connectedJoints(1)).springForce_N = ...
        joints(limbs(kk).connectedJoints(1)).springForce_N + ...
        limbs(kk).force_N;
    
    joints(limbs(kk).connectedJoints(2)).springForce_N = ...
        joints(limbs(kk).connectedJoints(2)).springForce_N - ...
        limbs(kk).force_N;
    
end

for jj = 1:length(joints)
    %     Sets a global speed limit to prevent physics breakdowns
    speed = sum(joints(jj).vel_mps.^2);
    
    if speed >= environment.maxSpeed_mps^2
        joints(jj).vel_mps =  joints(jj).vel_mps*(1/sqrt(speed)) * ...
            environment.maxSpeed_mps;
    end
    
    %     Checks for collisons between the current joint and the ground
    collided = check_collision(environment,joints(jj));
    
    if collided
        %         If the joint is phasing through the ground, the function
        %         will push it back slightly above the ground. This ignores
        %         any effect of vertical walls
        joints(jj).vel_mps(2) = -joints(jj).vel_mps(2) * ...
            environment.coeffRes;
       
        joints(jj).pos_m(2) = environment.pos_m(2) + ...
            joints(jj).radius_m;
              
    end
    
%     Finding the resultant force
    joints(jj).force_N = [0, joints(jj).mass_M*environment.g_mpsps] + ...
        joints(jj).springForce_N;
%     Setting a max force to prevent engine breakdowns
    if joints(jj).force_N(1) > environment.maxForce_N
        joints(jj).force_N(1) = environment.maxForce_N;
    end
    
    if joints(jj).force_N(2) > environment.maxForce_N
        joints(jj).force_N(2) = environment.maxForce_N;
    end
% % %     Force of Friction calculations using vertical normal force
    if collided
        %         Calculates friction. Notice we can only perform this calculation
        %         after calculating the vertical normal force.
        
%         If the joint is being pushed into the ground
        if joints(jj).force_N(2) < 0 
%             Coulomb's law 
        forceFric_N = abs(joints(jj).force_N(2)*environment.coeffFric);
        
        else
            forceFric_N = 0;
        end
        
        if forceFric_N < abs(joints(jj).force_N(1))
%             Important to note that Coulomb's law is an inequality,
%             meaning that the force of friction is only applied if the
%             total horizontal force is greater than mu*N
            if joints(jj).force_N(1) > 0
                joints(jj).force_N(1) = joints(jj).force_N(1) - forceFric_N;
            else
                joints(jj).force_N(1) = joints(jj).force_N(1) + forceFric_N;
            end
        end
    end
    
% % % Velocity-Verlet Integration
% % %    -- Similar to Euler integration, but instead uses the average
% acceleration between the previous acceleration and the acceleration
% at the current timestep to calculate the new acceleration. This helps to
% filter out random spikes in acceleration caused by collisions, etc.
    joints(jj).pos_m = joints(jj).pos_m + joints(jj).vel_mps * ...
        environment.dt_s +(.5*joints(jj).accel_mpsps * environment.dt_s^2);
    
    joints(jj).accel_mpsps = ((joints(jj).force_N/joints(jj).mass_M) + ...
        joints(jj).accel_mpsps)./2;
    
    joints(jj).vel_mps = joints(jj).vel_mps + joints(jj).accel_mpsps * ...
        environment.dt_s;

% % % % %     Euler Integration
% % %          ---- Second option for integration (only used for testing)
%     joints(jj).accel_mpsps = joints(jj).force_N/joints(jj).mass_M;
%     
%     joints(jj).vel_mps = joints(jj).vel_mps + joints(jj).accel_mpsps * ...
%         environment.dt_s;
%     
%     joints(jj).pos_m = joints(jj).pos_m + joints(jj).vel_mps * ...
%         environment.dt_s;
%     


     
end

end