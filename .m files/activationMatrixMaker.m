function activationMatrix = activationMatrixMaker(environment,limbs)

activationMatrix = zeros(floor(environment.endTime_s/environment.dt_s), 1, ...
    length(limbs));
numMinIndeces = floor(environment.minActivationTime_s/environment.dt_s);
rng('shuffle');
for gg = 1:length(limbs)
    
    for tt = 1:numMinIndeces:(floor(environment.endTime_s/environment.dt_s))
        
        coinToss = rand;
        if coinToss < .5
            activationMatrix(tt:tt+numMinIndeces-1,1,gg) = 0;
        else
            activationMatrix(tt:tt+numMinIndeces-1,1,gg) = 1;
        end
    end
end

activationMatrix = activationMatrix(1:floor(environment.endTime_s / ...
    environment.dt_s), 1,1:length(limbs));
end