% Intrinsic and Extrinsic Camera Parameters
%
% This script file can be directly executed under Matlab to recover the camera intrinsic and extrinsic parameters.
% IMPORTANT: This file contains neither the structure of the calibration objects nor the image coordinates of the calibration points.
%            All those complementary variables are saved in the complete matlab data file Calib_Results.mat.
% For more information regarding the calibration model visit http://www.vision.caltech.edu/bouguetj/calib_doc/


%-- Focal length:
fc = [ 1388.596594502995913 ; 1387.344160009693951 ];

%-- Principal point:
cc = [ 301.722550477224672 ; 196.169643635668592 ];

%-- Skew coefficient:
alpha_c = 0.000000000000000;

%-- Distortion coefficients:
kc = [ -0.067220977591130 ; -10.868206107809776 ; 0.001081060875435 ; 0.006008039513880 ; 0.000000000000000 ];

%-- Focal length uncertainty:
fc_error = [ 47.426683265061563 ; 46.936813425988603 ];

%-- Principal point uncertainty:
cc_error = [ 11.742099323742032 ; 15.856865029150503 ];

%-- Skew coefficient uncertainty:
alpha_c_error = 0.000000000000000;

%-- Distortion coefficients uncertainty:
kc_error = [ 0.168020712336353 ; 4.773396114507427 ; 0.003734332790278 ; 0.003593430111932 ; 0.000000000000000 ];

%-- Image size:
nx = 640;
ny = 480;


%-- Various other variables (may be ignored if you do not use the Matlab Calibration Toolbox):
%-- Those variables are used to control which intrinsic parameters should be optimized

n_ima = 11;						% Number of calibration images
est_fc = [ 1 ; 1 ];					% Estimation indicator of the two focal variables
est_aspect_ratio = 1;				% Estimation indicator of the aspect ratio fc(2)/fc(1)
center_optim = 1;					% Estimation indicator of the principal point
est_alpha = 0;						% Estimation indicator of the skew coefficient
est_dist = [ 1 ; 1 ; 1 ; 1 ; 0 ];	% Estimation indicator of the distortion coefficients


%-- Extrinsic parameters:
%-- The rotation (omc_kk) and the translation (Tc_kk) vectors for every calibration image and their uncertainties

%-- Image #1:
omc_1 = [ 2.094696e+00 ; 2.156448e+00 ; 1.867433e-01 ];
Tc_1  = [ -9.418120e+01 ; -2.597727e+01 ; 6.854275e+02 ];
omc_error_1 = [ 1.149408e-02 ; 1.084511e-02 ; 2.474298e-02 ];
Tc_error_1  = [ 5.779308e+00 ; 7.857742e+00 ; 2.360370e+01 ];

%-- Image #2:
omc_2 = [ 1.989437e+00 ; 2.095259e+00 ; 3.187201e-01 ];
Tc_2  = [ -8.483052e+01 ; -2.983787e+01 ; 6.549944e+02 ];
omc_error_2 = [ 9.256572e-03 ; 7.892964e-03 ; 1.930810e-02 ];
Tc_error_2  = [ 5.524265e+00 ; 7.503277e+00 ; 2.260830e+01 ];

%-- Image #3:
omc_3 = [ 2.180529e+00 ; 2.210269e+00 ; 1.129982e-02 ];
Tc_3  = [ -8.769992e+01 ; -3.024820e+01 ; 6.803395e+02 ];
omc_error_3 = [ 1.504733e-02 ; 1.466856e-02 ; 3.319717e-02 ];
Tc_error_3  = [ 5.732898e+00 ; 7.781943e+00 ; 2.361168e+01 ];

%-- Image #4:
omc_4 = [ -2.143825e+00 ; -2.257939e+00 ; -3.951852e-01 ];
Tc_4  = [ -7.496455e+01 ; -2.732318e+01 ; 6.535670e+02 ];
omc_error_4 = [ 8.313991e-03 ; 1.095879e-02 ; 2.060313e-02 ];
Tc_error_4  = [ 5.490669e+00 ; 7.480187e+00 ; 2.295770e+01 ];

%-- Image #5:
omc_5 = [ 2.008757e+00 ; 2.032408e+00 ; -6.736963e-02 ];
Tc_5  = [ -7.724050e+01 ; -3.724471e+01 ; 6.840613e+02 ];
omc_error_5 = [ 8.895695e-03 ; 8.703182e-03 ; 2.065659e-02 ];
Tc_error_5  = [ 5.765051e+00 ; 7.811692e+00 ; 2.279956e+01 ];

%-- Image #6:
omc_6 = [ -2.135563e+00 ; -2.237424e+00 ; -4.000806e-01 ];
Tc_6  = [ -6.564307e+01 ; -5.653147e+01 ; 6.168314e+02 ];
omc_error_6 = [ 8.688179e-03 ; 1.121799e-02 ; 1.952125e-02 ];
Tc_error_6  = [ 5.203598e+00 ; 7.051337e+00 ; 2.156146e+01 ];

%-- Image #7:
omc_7 = [ -2.091921e+00 ; -2.217928e+00 ; -2.017617e-01 ];
Tc_7  = [ -8.579920e+01 ; -4.242889e+01 ; 6.468601e+02 ];
omc_error_7 = [ 1.013363e-02 ; 1.175102e-02 ; 2.225995e-02 ];
Tc_error_7  = [ 5.447031e+00 ; 7.414327e+00 ; 2.254227e+01 ];

%-- Image #8:
omc_8 = [ -2.119848e+00 ; -2.137004e+00 ; 2.519003e-01 ];
Tc_8  = [ -9.056047e+01 ; -6.126750e+01 ; 6.692592e+02 ];
omc_error_8 = [ 1.074632e-02 ; 9.693887e-03 ; 2.221865e-02 ];
Tc_error_8  = [ 5.624748e+00 ; 7.648742e+00 ; 2.203908e+01 ];

%-- Image #9:
omc_9 = [ 1.827624e+00 ; 2.171474e+00 ; 2.907805e-01 ];
Tc_9  = [ -6.407396e+01 ; -5.434412e+01 ; 6.241791e+02 ];
omc_error_9 = [ 8.285364e-03 ; 7.848653e-03 ; 1.803878e-02 ];
Tc_error_9  = [ 5.264484e+00 ; 7.134017e+00 ; 2.144741e+01 ];

%-- Image #10:
omc_10 = [ 2.443989e+00 ; 1.797597e+00 ; 2.270931e-01 ];
Tc_10  = [ -1.029289e+02 ; -2.223080e+01 ; 6.850213e+02 ];
omc_error_10 = [ 1.220766e-02 ; 8.399504e-03 ; 2.374569e-02 ];
Tc_error_10  = [ 5.815287e+00 ; 7.854101e+00 ; 2.363619e+01 ];

%-- Image #11:
omc_11 = [ 1.651339e+00 ; 2.496675e+00 ; 1.096643e-01 ];
Tc_11  = [ -3.384855e+01 ; -8.171388e+01 ; 7.027999e+02 ];
omc_error_11 = [ 9.145688e-03 ; 1.295618e-02 ; 2.337770e-02 ];
Tc_error_11  = [ 5.925936e+00 ; 8.019654e+00 ; 2.393992e+01 ];

