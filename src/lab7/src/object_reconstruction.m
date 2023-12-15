function [M, O] = locate_objects()
    % Load original images
    left_image = imread('left01.ppm');
    right_image = imread('right01.ppm');

    % Convert to grayscale images
    left_grayscale = rgb2gray(left_image);
    right_grayscale = rgb2gray(right_image);

    % Binarize images
    left_bin = imbinarize(left_grayscale);
    right_bin = imbinarize(right_grayscale);

    % Inverse binary images
    left_ibin = ~left_bin;
    right_ibin = ~right_bin;

    %%% here just filling the holes smaller than a certain threshold
    left_ibin = bwareaopen(left_ibin , 1000);
    right_ibin = bwareaopen(right_ibin , 1000);

    % Fill image artifacts
    left_ibin_filled = imfill(left_ibin, 'holes');
    right_ibin_filled = imfill(right_ibin, 'holes');

    % Find centroids of objects
    left_label = bwlabel(left_ibin_filled);
    right_label = bwlabel(right_ibin_filled);

    left_stat = regionprops(left_label, 'centroid','Orientation', 'Area');
    right_stat = regionprops(right_label, 'centroid','Orientation', 'Area');

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

    M = ones(4,totalObj); 
    O = ones(1,totalObj);

    orientation_left = cat(1, left_stat.Orientation);
    orientation_right = cat(1, right_stat.Orientation);

    for x = 1:totalObj
        uv_left = left_stat(x).Centroid;
        uv_right = right_stat(x).Centroid;

        M(:,x) = [findXYZ(uv_left, uv_right, P_left, P_right);1];
        O(:,x) = (orientation_left(x)+orientation_right(x))/2;
    end

    rHw = [ 0 1 0 -389;
           -1 0 0  329;
            0 0 1 -325;
            0 0 0    1];

    M = rHw * M;
    result = ones(3, totalObj);

    for x = 1:totalObj
        result(:,x) = [M(1:2,x) O(:,x)];
    end

    file = fopen('results.txt', 'w');
    fprintf(file, '%f %f %f %f\n', result);
    fclose(file);
end
