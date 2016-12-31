function collided = check_collision(environment,joint)
% Checks to see if a joint is colliding with the ground at the current
% timestep.
collided = logical(0);

perimeter_m = [joint.pos_m(1)-joint.radius_m,joint.pos_m(2)-joint.radius_m,...
    joint.radius_m+joint.pos_m(1),joint.radius_m+joint.pos_m(2)];
if environment.pos_m(2)>= perimeter_m(2)
    %     Checks to see if the joint is contacting or is slightly
    %     phasing through the ground. This is the only collision we care
    %     about, since the joints can phase through one another and there
    %     are no walls or ceilings bounding the environment. 
    collided = logical(1);
end

end
 
