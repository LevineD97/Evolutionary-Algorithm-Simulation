function time = geneticAlgorithm(environment,joints,limbs,geneticOptions)
% Does most of the heavy lifting. Calls all the physics simulations,
% controls generation and population creation, and saves one of the first 
% creatures and the last survivors as their own .mat file

tic

for yy = 1:geneticOptions.populationSize
%     Initializes the activation matrices of the first generation. These
%     are entirely randomly generated

% % % %  Side Note: There's no need for this to be a 4D matrix. When I
% wrote this code, I was considering adding the ability for the magnitude
% of the activation force to change (think of a dimmer switch instead of a
% simple ON/OFF switch) as part of the genetic algorithm. I was in too deep
% by the time I realized I couldn't implement it before the due date, so I
% left it as is.
activationMatrices(:,1,:,yy) = activationMatrixMaker(environment, limbs);
end

firstOne = activationMatrices(:,:,:,1);
% Saves one of these first randomly generated creatures as a .mat file
save('firstOne.mat', 'firstOne');

CalculatingGeneration = 1;

while CalculatingGeneration <= geneticOptions.numOfGenerations
    CalculatingGeneration
%     Displays the current generation being calculated and erases the
%     previous generation's data
    animatePos_m = zeros((environment.endTime_s/environment.dt_s),2,length(joints),geneticOptions.populationSize);
    centerOfMass = zeros((environment.endTime_s/environment.dt_s),2,geneticOptions.populationSize);
    maxDistance = zeros(geneticOptions.populationSize,1);
    
    for rr = 1:geneticOptions.populationSize
%         goes through the entire population and simulates every creature's
%         physics. It then creates a vector of the maximum distances each
%         creature achieved during its simulation
        animatePos_m(:,:,:,rr) = physics(environment,joints,limbs,activationMatrices(:,:,:,rr));
        centerOfMass(:,:,rr) = centerOfMassCalculator(animatePos_m(:,:,:,rr),joints);
        maxDistance(rr) = max(centerOfMass(:,1,rr));
    end
%     Sorts the max distances and picks out the survivors. All the
%     creatures that were not fast enough to be included in this group die
%     out.
    [sortedMaxDistance,maxIndices] = sort(maxDistance,'descend');
    
    survivors = maxIndices(1:geneticOptions.numSurvive);
%     Creates a new generation of creatures based off the survivor's
%     activation matrices.
    activationMatrices = createNewGeneration(environment,activationMatrices(:,:,:,survivors),geneticOptions);
    
    CalculatingGeneration = CalculatingGeneration+1;
end
% finds the best performing creature of the last generation and saves it's
% activation matrix.
winner = activationMatrices(:,:,:,survivors(1));

save('winner.mat', 'winner');
time = toc;
