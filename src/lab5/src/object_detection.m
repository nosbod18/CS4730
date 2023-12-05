% Load original images
left_image = imread('images/detection/left01.ppm');
right_image = imread('images/detection/right01.ppm');

% Convert to grayscale images
left_grayscale = rgb2gray(left_image);
right_grayscale = rgb2gray(right_image);

% Binarize images
left_bin = imbinarize(left_grayscale);
right_bin = imbinarize(right_grayscale);

% Inverse binary images
left_ibin = ~left_bin;
right_ibin = ~right_bin;

% Fill image artifacts
left_ibin_filled = imfill(left_ibin, 'holes');
right_ibin_filled = imfill(right_ibin, 'holes');

% Find centroids of objects
left_label = bwlabel(left_ibin_filled);
right_label = bwlabel(right_ibin_filled);

left_stat = regionprops(left_label, 'centroid', 'orientation', 'area');
right_stat = regionprops(right_label, 'centroid', 'orientation', 'area');

totalObj = min([numel(left_stat), numel(right_stat)]);

% Create figure
figure(1)
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
hold on
imshow(left_ibin_filled)
title('Left Inverse Binarized Image')

for x = 1:totalObj
    plot(left_stat(x).Centroid(1),left_stat(x).Centroid(2),'ro');
end
hold off

subplot(3,2,6)
hold on
imshow(right_ibin_filled)
title('Right Inverse Binarized Image')

for x = 1:totalObj
    plot(right_stat(x).Centroid(1),right_stat(x).Centroid(2),'ro');
end
hold off



% 3D Reconstruction

left_calib = load('images/Calib_Results_left.mat');
right_calib = load('images/Calib_Results_right.mat');

K_left = left_calib.KK;
K_right = right_calib.KK;

R_left = left_calib.Rc_1;
R_right = right_calib.Rc_1;

T_left = left_calib.Tc_1;
T_right = right_calib.Tc_1;

P_left = K_left * [R_left, T_left];
P_right = K_right * [R_right, T_right];

M = zeros(3, totalObj);

for x = 1:totalObj
    uv_left = left_stat(x).Centroid;
    uv_right = right_stat(x).Centroid;
    M(:,x) = findXYZ(uv_left, uv_right, P_left, P_right);
end

%M  %#ok<NOPTS>