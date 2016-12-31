function newActivationMatrices = createNewGeneration(environment, ...
    survivorActivationMatrices, geneticOptions)
% Creates a new generation according to the options specified by the user.
% This new generation includes the survivors' activation matrices as well
% as many matrices that are "mutations" of these survivors. The new
% activation matrices have 4 dimensions as follows:
%  1st dimension: the row number corresponding to the timestep
%  2nd dimension: only 1 column, filled with either a zero or a one to
%      indicate the whether or not a limb is activated at a given timestep
%  3rd dimension: indicates which limbs the activation data in the first 2
%  dimensions belong to.
%  4th dimension: indicates which creature in the entire population the
%  activation matrix belongs to


% Seeding the random number generator
rng('shuffle');

activationMatrixSize = size(survivorActivationMatrices);
% initializes the new
newActivationMatrices = zeros(environment.numTimeSteps, ...
    1,activationMatrixSize(3),geneticOptions.populationSize);

for jj = 1:geneticOptions.populationSize
    %     Calls mutate for every new creature in the population
    if rand < geneticOptions.matingVsMutationChance;
        newActivationMatrices(:,:,:,jj) = mate(environment, survivorActivationMatrices,geneticOptions);
    else
        newActivationMatrices(:,:,:,jj) = mutate(environment, survivorActivationMatrices,geneticOptions);
    end
end
%     Trims off the size of the new activation matrix in case we had any
%     remainders, such as if the timestep didn't perfectly divid into the
%     end time.
newActivationMatrices = newActivationMatrices(1:environment.numTimeSteps,1,1:activationMatrixSize(3),:);
% Replaces the previous survivors into the new generation, in case the new
% generation yields no improvement over the old one.
newActivationMatrices(:,1,:,1:geneticOptions.numSurvive) = survivorActivationMatrices(:,1,:,:);
end

function activationMatrix = mutate(environment, survivorActivationMatrices, geneticOptions)
% Mutates a given activation matrix according to the mutation Chance
% specified in geneticOptions

%
numMinIndeces = floor(environment.minActivationTime_s/environment.dt_s);
activationMatrixSize = size(survivorActivationMatrices);

% randomly chooses a survivor on which to base this particular creature on
whichSurvivor = randi(geneticOptions.numSurvive);

activationMatrix = survivorActivationMatrices(:,1,:,whichSurvivor);

for gg = 1:activationMatrixSize(3)
    for yy = 1:numMinIndeces:environment.numTimeSteps
        coinToss = rand;
        if coinToss < geneticOptions.mutationChance
            %             If the coinToss is less than the mutation chance, that block
            %             of length(minIndeces) will convert to the opposite value it
            %             currently has(ie a block of ones would change to a block of
            %             zeros and vice-versa
            activationMatrix(yy:yy+numMinIndeces-1, 1, gg) = ...
                ~activationMatrix(yy:yy+numMinIndeces-1,1,gg);
        end
    end
end
end

function activationMatrix = mate(environment, survivorActivationMatrices, geneticOptions)
% Chooses 2 survivor parents at random. Notice that the same parent can
% mate with itself, as a form of psuedo-mutation.
survivorParent1 = randi(geneticOptions.numSurvive);
survivorParent2 = randi(geneticOptions.numSurvive);

activationMatrixSize = size(survivorActivationMatrices(:,:,:,1));
numMinIndeces = floor(environment.minActivationTime_s/environment.dt_s);

activationMatrix = zeros(activationMatrixSize);

%     for uu = the number of limbs the creature has
for uu = 1:activationMatrixSize(3)
%     numMinIndeces corresponds to the minimum activation time of a tendon
    for rr = 1:numMinIndeces:environment.numTimeSteps
%         If the "genetic information" between two parents is the same, it
%         has a very high chance of being passed to their offspring
        if survivorActivationMatrices(rr, 1, uu, survivorParent1) == ...
                survivorActivationMatrices(rr, 1, uu, survivorParent2)
            coinToss = rand;
            if coinToss <= geneticOptions.matingChance
                activationMatrix(rr:rr+numMinIndeces-1, 1, uu) = ...
                    survivorActivationMatrices(rr:rr+numMinIndeces-1,1,uu, ...
                    survivorParent1);
            else
                activationMatrix(rr:rr+numMinIndeces-1, 1, uu) = ...
                    ~survivorActivationMatrices(rr:rr+numMinIndeces-1,1,uu, ...
                    survivorParent1);
            end
        else
%             If the "genetic information" between two parents is
%             different, a random value is assigned to the offspring for
%             that timestep
            coinToss2 = rand;
            if coinToss2 < .5
                activationMatrix(rr:rr+numMinIndeces-1, 1, uu) = 1;
            else
                activationMatrix(rr:rr+numMinIndeces-1, 1, uu) = 1;
            end
        end
    end
end
end




