function nobj = move_object()
    system('save_single_image puma1 0 > /dev/null');

    % Load original images
    left_image = imread('left0.ppm');
    right_image = imread('right0.ppm');

    % Convert to grayscale images
    left_grayscale = rgb2gray(left_image);
    right_grayscale = rgb2gray(right_image);

    % Binarize images
    left_bin = imbinarize(left_grayscale);
    right_bin = imbinarize(right_grayscale);

    % Inverse binary images
    left_ibin = ~left_bin;
    right_ibin = ~right_bin;

    % Fill the holes smaller than a certain threshold
    left_ibin = bwareaopen(left_ibin , 1000);
    right_ibin = bwareaopen(right_ibin , 1000);

    % Fill image artifacts
    left_ibin_filled = imfill(left_ibin, 'holes');
    right_ibin_filled = imfill(right_ibin, 'holes');

    % Find centroids of objects
    left_label = bwlabel(left_ibin_filled);
    right_label = bwlabel(right_ibin_filled);

    left_stat = regionprops(left_label, 'centroid', 'Orientation', 'Area');
    right_stat = regionprops(right_label, 'centroid', 'Orientation', 'Area');

    nobj = numel(left_stat);

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

    orientation_left = cat(1, left_stat.Orientation);
    orientation_right = cat(1, right_stat.Orientation);

    uv_left = left_stat(1).Centroid;
    uv_right = right_stat(1).Centroid;

    M = [findXYZ(uv_left, uv_right, P_left, P_right);1];
    O = (orientation_left(1)+orientation_right(1))/2;

    rHw = [ 0 1 0 -389;
           -1 0 0  329;
            0 0 1 -325;
            0 0 0    1];

    M = rHw * M;
    x = M(1);
    y = M(2);
    t = 90 - O;
    o = 0;
    a = 90;

    %x = x + 130 * cos(90)
    %y = y - 130 * sin(90)

    % Move to object and grab it
    system(sprintf('PumaMoveXYZOAT %d %d -66 %d %d %d', x, y, o, a, t));
    %pause(1);
    system('openGripper');
    %pause(1);
    system(sprintf('PumaMoveXYZOAT %d %d -184 %d %d %d', x, y, o, a, t));
    %pause(1);
    system('closeGripper');
    %pause(1);

    % Move up and over to be clear of the camera stand
    system(sprintf('PumaMoveXYZOAT %d %d -66 0 90 %ds', x, y, t));
    %pause(1);
    system('PumaMoveXYZOAT 126 282 -66 0 90 0');
    %pause(1);

    % Flip over and drop object
    system('PumaMoveJoints -90 -90 90 0 0 0');
    pause(9);
    system('PumaMoveJoints 90 -90 90 0 0 0');
    pause(17);
    system('PumaMoveXYZOAT -115 -400 -135 0 0 180');
    pause(1);
    system('openGripper');
    pause(1);
    system('closeGripper');
    pause(1);

    % Flip back over
    system('PumaMoveJoints 90 -90 90 0 0 0');
    pause(9);
    system('PumaMoveJoints -90 -90 90 0 0 0');
    pause(18);
    system('PumaMoveXYZOAT 126 282 -66 0 90 0');
    pause(1);
end
