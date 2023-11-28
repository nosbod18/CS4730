% Intrinsic and Extrinsic Camera Parameters
%
% This script file can be directly executed under Matlab to recover the camera intrinsic and extrinsic parameters.
% IMPORTANT: This file contains neither the structure of the calibration objects nor the image coordinates of the calibration points.
%            All those complementary variables are saved in the complete matlab data file Calib_Results.mat.
% For more information regarding the calibration model visit http://www.vision.caltech.edu/bouguetj/calib_doc/


%-- Focal length:
fc = [ 1359.350454312621423 ; 1356.929511926782425 ];

%-- Principal point:
cc = [ 347.624563669818826 ; 215.745605270873284 ];

%-- Skew coefficient:
alpha_c = 0.000000000000000;

%-- Distortion coefficients:
kc = [ 0.016161679619233 ; -2.446550606290399 ; -0.006014407019797 ; 0.009031514227295 ; 0.000000000000000 ];

%-- Focal length uncertainty:
fc_error = [ 13.863081882588100 ; 13.861070700816896 ];

%-- Principal point uncertainty:
cc_error = [ 13.830154657644462 ; 13.907382731395842 ];

%-- Skew coefficient uncertainty:
alpha_c_error = 0.000000000000000;

%-- Distortion coefficients uncertainty:
kc_error = [ 0.101425253102726 ; 2.342881750584880 ; 0.002894268471656 ; 0.002751962768668 ; 0.000000000000000 ];

%-- Image size:
nx = 640;
ny = 480;


%-- Various other variables (may be ignored if you do not use the Matlab Calibration Toolbox):
%-- Those variables are used to control which intrinsic parameters should be optimized

n_ima = 10;						% Number of calibration images
est_fc = [ 1 ; 1 ];					% Estimation indicator of the two focal variables
est_aspect_ratio = 1;				% Estimation indicator of the aspect ratio fc(2)/fc(1)
center_optim = 1;					% Estimation indicator of the principal point
est_alpha = 0;						% Estimation indicator of the skew coefficient
est_dist = [ 1 ; 1 ; 1 ; 1 ; 0 ];	% Estimation indicator of the distortion coefficients


%-- Extrinsic parameters:
%-- The rotation (omc_kk) and the translation (Tc_kk) vectors for every calibration image and their uncertainties

%-- Image #1:
omc_1 = [ 2.140322e+00 ; 2.138734e+00 ; 1.812494e-01 ];
Tc_1  = [ -1.052732e+02 ; -3.145938e+01 ; 6.588347e+02 ];
omc_error_1 = [ 8.766385e-03 ; 7.982905e-03 ; 1.983038e-02 ];
Tc_error_1  = [ 6.722011e+00 ; 6.804512e+00 ; 6.848711e+00 ];

%-- Image #2:
omc_2 = [ 1.594065e+00 ; 2.543278e+00 ; 1.101769e-01 ];
Tc_2  = [ -5.798703e+01 ; -7.352868e+01 ; 6.697039e+02 ];
omc_error_2 = [ 6.650707e-03 ; 9.935262e-03 ; 1.890098e-02 ];
Tc_error_2  = [ 6.819067e+00 ; 6.889873e+00 ; 6.891230e+00 ];

%-- Image #3:
omc_3 = [ 2.545245e+00 ; 1.673051e+00 ; 2.223916e-01 ];
Tc_3  = [ -1.183986e+02 ; -4.082140e+00 ; 6.563131e+02 ];
omc_error_3 = [ 9.621987e-03 ; 5.678252e-03 ; 1.975361e-02 ];
Tc_error_3  = [ 6.720107e+00 ; 6.780201e+00 ; 6.835099e+00 ];

%-- Image #4:
omc_4 = [ -1.951833e+00 ; -2.013323e+00 ; -7.008286e-01 ];
Tc_4  = [ -8.358410e+01 ; -5.223947e+01 ; 5.713041e+02 ];
omc_error_4 = [ 6.012508e-03 ; 9.142824e-03 ; 1.526407e-02 ];
Tc_error_4  = [ 5.810501e+00 ; 5.904637e+00 ; 6.016353e+00 ];

%-- Image #5:
omc_5 = [ 1.854710e+00 ; 1.925055e+00 ; 5.581495e-01 ];
Tc_5  = [ -8.829180e+01 ; -6.306719e+01 ; 5.714747e+02 ];
omc_error_5 = [ 8.119091e-03 ; 6.447424e-03 ; 1.421827e-02 ];
Tc_error_5  = [ 5.846409e+00 ; 5.903299e+00 ; 6.110830e+00 ];

%-- Image #6:
omc_6 = [ -2.629397e+00 ; -8.828510e-02 ; -2.107098e-01 ];
Tc_6  = [ -7.928287e+01 ; 9.980744e+01 ; 6.351393e+02 ];
omc_error_6 = [ 1.039622e-02 ; 3.881095e-03 ; 1.422292e-02 ];
Tc_error_6  = [ 6.488964e+00 ; 6.515752e+00 ; 6.046473e+00 ];

%-- Image #7:
omc_7 = [ 6.362100e-01 ; 2.311797e+00 ; -1.584003e-01 ];
Tc_7  = [ 2.365223e+01 ; -9.901107e+01 ; 6.601070e+02 ];
omc_error_7 = [ 5.393339e-03 ; 9.771570e-03 ; 1.271819e-02 ];
Tc_error_7  = [ 6.710095e+00 ; 6.754174e+00 ; 6.370766e+00 ];

%-- Image #8:
omc_8 = [ 2.091819e+00 ; 2.203801e+00 ; 1.954602e-01 ];
Tc_8  = [ -8.153829e+01 ; -5.375299e+01 ; 5.599261e+02 ];
omc_error_8 = [ 7.742495e-03 ; 7.172627e-03 ; 1.817151e-02 ];
Tc_error_8  = [ 5.707853e+00 ; 5.777336e+00 ; 5.766742e+00 ];

%-- Image #9:
omc_9 = [ -2.189552e+00 ; -2.151417e+00 ; 1.142024e-01 ];
Tc_9  = [ -7.629871e+01 ; -4.927288e+01 ; 6.135909e+02 ];
omc_error_9 = [ 9.464338e-03 ; 9.227426e-03 ; 1.974438e-02 ];
Tc_error_9  = [ 6.235809e+00 ; 6.291823e+00 ; 6.052708e+00 ];

%-- Image #10:
omc_10 = [ 5.173098e-01 ; 2.935472e+00 ; -6.563973e-01 ];
Tc_10  = [ 1.583042e+01 ; -8.178112e+01 ; 6.566281e+02 ];
omc_error_10 = [ 2.431264e-03 ; 1.016266e-02 ; 1.663834e-02 ];
Tc_error_10  = [ 6.658786e+00 ; 6.719678e+00 ; 6.183793e+00 ];

