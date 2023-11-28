% Intrinsic and Extrinsic Camera Parameters
%
% This script file can be directly executed under Matlab to recover the camera intrinsic and extrinsic parameters.
% IMPORTANT: This file contains neither the structure of the calibration objects nor the image coordinates of the calibration points.
%            All those complementary variables are saved in the complete matlab data file Calib_Results.mat.
% For more information regarding the calibration model visit http://www.vision.caltech.edu/bouguetj/calib_doc/


%-- Focal length:
fc = [ 1357.478664915660147 ; 1353.995562239262199 ];

%-- Principal point:
cc = [ 297.607066454376877 ; 196.214019472255984 ];

%-- Skew coefficient:
alpha_c = 0.000000000000000;

%-- Distortion coefficients:
kc = [ -0.166038357503822 ; -4.835775328679039 ; -0.000535803106969 ; 0.001008875810204 ; 0.000000000000000 ];

%-- Focal length uncertainty:
fc_error = [ 49.365895503631421 ; 49.861489899811929 ];

%-- Principal point uncertainty:
cc_error = [ 25.595615962752305 ; 16.968732031441569 ];

%-- Skew coefficient uncertainty:
alpha_c_error = 0.000000000000000;

%-- Distortion coefficients uncertainty:
kc_error = [ 0.143189919815198 ; 3.995383368121042 ; 0.003254824861352 ; 0.004739526043379 ; 0.000000000000000 ];

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
omc_1 = [ -2.113356e+00 ; -2.164947e+00 ; 2.215446e-01 ];
Tc_1  = [ -1.101822e+02 ; -3.054736e+01 ; 7.316135e+02 ];
omc_error_1 = [ 1.394327e-02 ; 1.341965e-02 ; 2.588176e-02 ];
Tc_error_1  = [ 1.369999e+01 ; 9.199513e+00 ; 2.683570e+01 ];

%-- Image #2:
omc_2 = [ -2.170652e+00 ; -2.270585e+00 ; 5.927172e-02 ];
Tc_2  = [ -1.123770e+02 ; -3.422015e+01 ; 6.981798e+02 ];
omc_error_2 = [ 1.591005e-02 ; 1.659880e-02 ; 3.351057e-02 ];
Tc_error_2  = [ 1.312566e+01 ; 8.786278e+00 ; 2.552121e+01 ];

%-- Image #3:
omc_3 = [ -2.042782e+00 ; -2.063265e+00 ; 3.650372e-01 ];
Tc_3  = [ -1.064424e+02 ; -3.465652e+01 ; 7.220545e+02 ];
omc_error_3 = [ 1.402920e-02 ; 1.227701e-02 ; 2.252049e-02 ];
Tc_error_3  = [ 1.353228e+01 ; 9.078418e+00 ; 2.602733e+01 ];

%-- Image #4:
omc_4 = [ -2.031663e+00 ; -2.056232e+00 ; -5.968945e-03 ];
Tc_4  = [ -1.035803e+02 ; -3.180736e+01 ; 6.938379e+02 ];
omc_error_4 = [ 1.238190e-02 ; 1.465518e-02 ; 2.290059e-02 ];
Tc_error_4  = [ 1.301932e+01 ; 8.719136e+00 ; 2.565659e+01 ];

%-- Image #5:
omc_5 = [ 2.120165e+00 ; 2.218837e+00 ; -4.617295e-01 ];
Tc_5  = [ -9.611724e+01 ; -4.168086e+01 ; 7.189155e+02 ];
omc_error_5 = [ 9.358317e-03 ; 1.369885e-02 ; 2.650093e-02 ];
Tc_error_5  = [ 1.348196e+01 ; 9.020120e+00 ; 2.574056e+01 ];

%-- Image #6:
omc_6 = [ -2.031853e+00 ; -2.040114e+00 ; -1.683662e-02 ];
Tc_6  = [ -1.078767e+02 ; -6.073945e+01 ; 6.548429e+02 ];
omc_error_6 = [ 1.240332e-02 ; 1.401245e-02 ; 2.261015e-02 ];
Tc_error_6  = [ 1.229292e+01 ; 8.235075e+00 ; 2.416521e+01 ];

%-- Image #7:
omc_7 = [ -1.950483e+00 ; -1.996376e+00 ; 1.736687e-01 ];
Tc_7  = [ -1.160993e+02 ; -4.672976e+01 ; 6.915481e+02 ];
omc_error_7 = [ 1.289203e-02 ; 1.365929e-02 ; 2.136278e-02 ];
Tc_error_7  = [ 1.296817e+01 ; 8.706705e+00 ; 2.521934e+01 ];

%-- Image #8:
omc_8 = [ -1.907356e+00 ; -1.914978e+00 ; 5.675871e-01 ];
Tc_8  = [ -1.138057e+02 ; -6.544913e+01 ; 7.102960e+02 ];
omc_error_8 = [ 1.512610e-02 ; 1.203917e-02 ; 2.096196e-02 ];
Tc_error_8  = [ 1.337263e+01 ; 8.945761e+00 ; 2.483401e+01 ];

%-- Image #9:
omc_9 = [ 2.007183e+00 ; 2.376148e+00 ; -2.760994e-02 ];
Tc_9  = [ -1.043321e+02 ; -5.850053e+01 ; 6.581975e+02 ];
omc_error_9 = [ 1.411988e-02 ; 1.714498e-02 ; 3.236320e-02 ];
Tc_error_9  = [ 1.239715e+01 ; 8.287964e+00 ; 2.388670e+01 ];

%-- Image #10:
omc_10 = [ -2.451644e+00 ; -1.793149e+00 ; 2.580833e-01 ];
Tc_10  = [ -1.188026e+02 ; -2.686986e+01 ; 7.329635e+02 ];
omc_error_10 = [ 1.517208e-02 ; 9.725256e-03 ; 2.639393e-02 ];
Tc_error_10  = [ 1.371732e+01 ; 9.201211e+00 ; 2.691234e+01 ];

%-- Image #11:
omc_11 = [ -1.661132e+00 ; -2.499395e+00 ; 1.708774e-01 ];
Tc_11  = [ -4.974114e+01 ; -8.678805e+01 ; 7.211545e+02 ];
omc_error_11 = [ 1.107622e-02 ; 1.583696e-02 ; 2.491303e-02 ];
Tc_error_11  = [ 1.355061e+01 ; 9.030636e+00 ; 2.639540e+01 ];

