function [imgData] = takeScreenshot(robot, left, top, width, height)
% CodingLikeMad Youtube Channel

% Take full screen capture
t = java.awt.Toolkit.getDefaultToolkit();
rect = java.awt.Rectangle(t.getScreenSize());

% Take screen capture
% pos = [left top width height]; % [left top width height]
% rect = java.awt.Rectangle(pos(1),pos(2),pos(3),pos(4));

cap = robot.createScreenCapture(rect);


% Convert to an RGB image
rgb = typecast(cap.getRGB(0,0,cap.getWidth,cap.getHeight,[],0,cap.getWidth),'uint8');
imgData = zeros(cap.getHeight,cap.getWidth,3,'uint8');
imgData(:,:,1) = reshape(rgb(3:4:end),cap.getWidth,[])';
imgData(:,:,2) = reshape(rgb(2:4:end),cap.getWidth,[])';
imgData(:,:,3) = reshape(rgb(1:4:end),cap.getWidth,[])';

end