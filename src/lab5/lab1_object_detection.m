% Load original images
left_image = imread('left03.ppm');
right_image = imread('right03.ppm');

% Convert to grayscale images
left_grayscale = rgb2gray(left_image);
right_grayscale = rgb2gray(right_image);

% Binarize images
left_bin = imbinarize(left_grayscale);
right_bin = imbinarize(right_grayscale);

% Inverse binary images
left_ibin = ~left_bin;
right_ibin = ~right_bin;

%%% Added by Jacket ... Your detection was not robuts, 
%%% here just filling the holes smaller than a certain threshold
left_ibin = bwareaopen (left_ibin , 1000);
right_ibin = bwareaopen (right_ibin , 1000);

% Fill image artifacts
left_ibin_filled = imfill(left_ibin, 'holes');
right_ibin_filled = imfill(right_ibin, 'holes');

% Find centroids of objects
left_label = bwlabel(left_ibin_filled);
right_label = bwlabel(right_ibin_filled);

%left_stat = regionprops(left_label, 'centroid');
%right_stat = regionprops(right_label, 'centroid');

%%% Added by Jacket: get the orientation too
left_stat = regionprops(left_label, 'centroid','Orientation', 'Area');
right_stat = regionprops(right_label, 'centroid','Orientation', 'Area');

% Create figure
figure(1)
hold on

subplot(3,2,1) 
imshow(left_image)
title('Left Original Image')

subplot(3,2,2) 
imshow(right_image)
title('Right Original Image')

subplot(3,2,3) 
imshow(left_bin)
title('Left Binarized Image')

subplot(3,2,4) 
imshow(right_bin)
title('Right Binarized Image')

subplot(3,2,5)
imshow(left_ibin_filled)
centroids_left = cat(1, left_stat.Centroid);
hold on 
for i = 1:numel(centroids_left(:,1))
    scatter(centroids_left(:,1), centroids_left(:,2), 'b')
    text(centroids_left(i,1)+15, centroids_left(i,2), num2str(i), 'Color', 'b')
end
hold off
title('Left Inverse Binarized Image')

%plot(left_stat(1).Centroid(1),left_stat(1).Centroid(2),'ro');
%plot(left_stat(2).Centroid(1),left_stat(2).Centroid(2),'ro');
%plot(left_stat(3).Centroid(1),left_stat(3).Centroid(2),'ro');
%plot(left_stat(4).Centroid(1),left_stat(4).Centroid(2),'ro');

subplot(3,2,6) 
imshow(right_ibin_filled)
centroids_right = cat(1, right_stat.Centroid);
hold on 
for i = 1:numel(centroids_right(:,1))
    scatter(centroids_right(:,1), centroids_right(:,2), 'b')
    text(centroids_right(i,1)+15, centroids_right(i,2), num2str(i), 'Color', 'b')
end
hold off
title('Right Inverse Binarized Image')

%plot(right_stat(1).Centroid(1),right_stat(1).Centroid(2),'ro');
%plot(right_stat(2).Centroid(1),right_stat(2).Centroid(2),'ro');
%plot(right_stat(3).Centroid(1),right_stat(3).Centroid(2),'ro');
%plot(right_stat(7).Centroid(1),right_stat(7).Centroid(2),'ro');

hold off



% 3D Reconstruction

left_calib = load('Calib_Results_left.mat');
right_calib = load('Calib_Results_right.mat');

K_left = left_calib.KK;
K_right = right_calib.KK;

R_left = left_calib.Rc_1;
R_right = right_calib.Rc_1;

T_left = left_calib.Tc_1;
T_right = right_calib.Tc_1;

P_left = K_left * [R_left, T_left];
P_right = K_right * [R_right, T_right];

totalObj = numel(left_stat); 
%M = ones(3,totalObj);

%%% Added by Jacket: just to have the homogeneous form
M = ones(4,totalObj); 
Orientations = ones(1,totalObj); 

orientation_left = cat(1, left_stat.Orientation);
orientation_right = cat(1, right_stat.Orientation);

for x = 1:totalObj
    uv_left = left_stat(x).Centroid;
    uv_right = right_stat(x).Centroid;
    %M(:,x) = findXYZ(uv_left, uv_right, P_left, P_right);
    
    %%% Added by Jacket
    M(:,x) = [findXYZ(uv_left, uv_right, P_left, P_right);1];
    Orientations(:,x) = (orientation_left(x)+orientation_right(x))/2;
end

M  %#ok<NOPTS>
Orientations  %#ok<NOPTS>





