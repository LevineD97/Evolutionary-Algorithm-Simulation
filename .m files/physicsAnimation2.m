function physicsAnimation2(environment,joints,limbs,activationMatrix1,activationMatrix2,animateOptions)
% Simulates two tiled Activation Matrices to create longer animations
% containing many "steps". Although it can be used for any activation
% matrix from any generation, it will be used to animate a creature from
% the first generation alongside the best performing creature from the last of
% the generation.

% Doing the Tiling:
activationMatrixExtended1 = repmat(activationMatrix1,animateOptions.cyclesPerAnimation);
activationMatrixExtended2 = repmat(activationMatrix2,animateOptions.cyclesPerAnimation);
% Setting the simulation time to be longer:
environment.numTimeSteps = length(activationMatrixExtended1);
% Simulating with the new tiled matrix:
animatePos_m1 = physics(environment,joints,limbs,activationMatrixExtended1);
animatePos_m2 = physics(environment,joints,limbs,activationMatrixExtended2);
% Animating:
animator2(animatePos_m1,animatePos_m2, joints, limbs, animateOptions, activationMatrixExtended1, activationMatrixExtended2);