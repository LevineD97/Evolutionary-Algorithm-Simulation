function animator2(animatePos_m1, animatePos_m2, joints, limbs, animateOptions, ...
    activationMatrix1, activationMatrix2)
% Animates 2 creatures side by side

% Setting up the window so it works with most screens:
figure('units','normalized','outerposition',[0 .04 1 .96])

set(0,'defaultaxesposition',[0 0 1 1])

mario = imread('mario.jpg');
mario = flipud(mario);
image('XData',[0,50],'YData',[0,15],'CData',mario);
hold on

for jj = 1:length(joints)
    %     Initializes the joint plots
    p(jj) = plot(NaN,NaN,'.', 'markersize', animateOptions.jointSize_px, ...
        'color', animateOptions.jointColor);
    hold on
    t(jj) = plot(NaN,NaN,'.', 'markersize', animateOptions.jointSize_px, ...
        'color', animateOptions.jointColor);
    
end

for kk = 1:length(limbs)
    %     Initializes the limbs' lines
    q(kk) = line(NaN,NaN,'linewidth', animateOptions.limbWidth_px, 'color', ...
        animateOptions.limbRestColor);
    i(kk) = line(NaN,NaN,'linewidth', animateOptions.limbWidth_px, 'color', ...
        animateOptions.limbRestColor);
    
end

axis(animateOptions.windowSize_px);

grid off

b = text(1,14, 'First Generation','fontweight','bold', 'fontsize', 40, 'color', 'w');
c = text(1,6.5, 'Last Generation','fontweight','bold', 'fontsize', 40, 'color', 'w');

animatePos_m2(:,2,:) = animatePos_m2(:,2,:)+(.5*animateOptions.windowSize_px(4))+.7;

animatePos_m1(:,2,:) = animatePos_m1(:,2,:)+1.7;

for kk = 1:length(animatePos_m1)
    %     Main animation loop
    
    for ii = 1:length(joints)
        %   Sets the joint position data for the first creature for a given
        %      frame
        set(p(ii),'XData',animatePos_m1(kk,1,ii),'YData', ...
            animatePos_m1(kk,2,ii));
    end
    
    for hh = 1:length(limbs)
        %    Sets the limb position data for the first creature for a given
        %     frame
        if activationMatrix1(kk,1,hh)
            currentColor = animateOptions.limbActivatedColor;
        else
            currentColor = animateOptions.limbRestColor;
        end
        set(q(hh),'XData',[animatePos_m1(kk,1,(limbs(hh).connectedJoints(1))),...
            animatePos_m1(kk,1,(limbs(hh).connectedJoints(2)))], 'YData', ...
            [animatePos_m1(kk,2,(limbs(hh).connectedJoints(1))), ...
            animatePos_m1(kk,2,(limbs(hh).connectedJoints(2)))], ...
            'color', currentColor);
    end
    
    
    for ii = 1:length(joints)
        %   Sets the joint position data for the first creature for a given
        %      frame
        set(t(ii),'XData',animatePos_m2(kk,1,ii),'YData', ...
            animatePos_m2(kk,2,ii));
    end
    
    for hh = 1:length(limbs)
        %    Sets the limb position data for the first creature for a given
        %     frame
        if activationMatrix2(kk,1,hh)
            currentColor = animateOptions.limbActivatedColor;
        else
            currentColor = animateOptions.limbRestColor;
        end
        set(i(hh),'XData',[animatePos_m2(kk,1,(limbs(hh).connectedJoints(1))),...
            animatePos_m2(kk,1,(limbs(hh).connectedJoints(2)))], 'YData', ...
            [animatePos_m2(kk,2,(limbs(hh).connectedJoints(1))), ...
            animatePos_m2(kk,2,(limbs(hh).connectedJoints(2)))], ...
            'color', currentColor);
    end
    
    pause(animateOptions.frameRate_s);
end
clear; clc; close all