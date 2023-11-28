% Intrinsic and Extrinsic Camera Parameters
%
% This script file can be directly executed under Matlab to recover the camera intrinsic and extrinsic parameters.
% IMPORTANT: This file contains neither the structure of the calibration objects nor the image coordinates of the calibration points.
%            All those complementary variables are saved in the complete matlab data file Calib_Results.mat.
% For more information regarding the calibration model visit http://www.vision.caltech.edu/bouguetj/calib_doc/


%-- Focal length:
fc = [ 1352.126330041149004 ; 1351.164816891214514 ];

%-- Principal point:
cc = [ 293.906410498716184 ; 207.917738795935009 ];

%-- Skew coefficient:
alpha_c = 0.000000000000000;

%-- Distortion coefficients:
kc = [ -0.137667840478846 ; 0.705172128412469 ; -0.009060300728487 ; 0.000314202631138 ; 0.000000000000000 ];

%-- Focal length uncertainty:
fc_error = [ 13.798674858892966 ; 13.623959618525298 ];

%-- Principal point uncertainty:
cc_error = [ 14.729826082500235 ; 13.882531300634970 ];

%-- Skew coefficient uncertainty:
alpha_c_error = 0.000000000000000;

%-- Distortion coefficients uncertainty:
kc_error = [ 0.109123299981402 ; 2.596979896414177 ; 0.002863324766746 ; 0.003015471660898 ; 0.000000000000000 ];

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
omc_1 = [ -2.151761e+00 ; -2.129223e+00 ; 1.834381e-01 ];
Tc_1  = [ -8.733583e+01 ; -3.833346e+01 ; 6.917934e+02 ];
omc_error_1 = [ 9.680371e-03 ; 9.472427e-03 ; 1.950261e-02 ];
Tc_error_1  = [ 7.529817e+00 ; 7.125234e+00 ; 6.986821e+00 ];

%-- Image #2:
omc_2 = [ -1.603414e+00 ; -2.532475e+00 ; 1.331213e-01 ];
Tc_2  = [ -4.020212e+01 ; -8.085308e+01 ; 6.837956e+02 ];
omc_error_2 = [ 7.315344e-03 ; 1.163318e-02 ; 1.881891e-02 ];
Tc_error_2  = [ 7.442471e+00 ; 7.039428e+00 ; 6.911117e+00 ];

%-- Image #3:
omc_3 = [ -2.558738e+00 ; -1.664865e+00 ; 2.233917e-01 ];
Tc_3  = [ -1.002341e+02 ; -1.087550e+01 ; 6.941673e+02 ];
omc_error_3 = [ 1.114849e-02 ; 6.798635e-03 ; 1.985868e-02 ];
Tc_error_3  = [ 7.559269e+00 ; 7.142825e+00 ; 7.025138e+00 ];

%-- Image #4:
omc_4 = [ -1.924686e+00 ; -1.795976e+00 ; -3.582448e-01 ];
Tc_4  = [ -9.600115e+01 ; -5.812807e+01 ; 6.006969e+02 ];
omc_error_4 = [ 7.210188e-03 ; 8.469398e-03 ; 1.557557e-02 ];
Tc_error_4  = [ 6.556529e+00 ; 6.206404e+00 ; 6.402705e+00 ];

%-- Image #5:
omc_5 = [ 2.072113e+00 ; 2.121432e+00 ; 2.654707e-01 ];
Tc_5  = [ -1.010117e+02 ; -6.885283e+01 ; 6.020361e+02 ];
omc_error_5 = [ 8.020795e-03 ; 7.527854e-03 ; 1.949663e-02 ];
Tc_error_5  = [ 6.579478e+00 ; 6.230194e+00 ; 6.359874e+00 ];

%-- Image #6:
omc_6 = [ -2.612951e+00 ; 4.137561e-02 ; 2.298446e-01 ];
Tc_6  = [ -6.952149e+01 ; 9.304944e+01 ; 6.607466e+02 ];
omc_error_6 = [ 1.052068e-02 ; 4.517724e-03 ; 1.559604e-02 ];
Tc_error_6  = [ 7.256359e+00 ; 6.810273e+00 ; 6.258439e+00 ];

%-- Image #7:
omc_7 = [ 6.688687e-01 ; 2.625542e+00 ; -2.811270e-01 ];
Tc_7  = [ 3.341346e+01 ; -1.066724e+02 ; 6.491176e+02 ];
omc_error_7 = [ 3.905411e-03 ; 1.040892e-02 ; 1.600457e-02 ];
Tc_error_7  = [ 7.076139e+00 ; 6.698806e+00 ; 6.219552e+00 ];

%-- Image #8:
omc_8 = [ -2.083930e+00 ; -2.164096e+00 ; 1.463160e-01 ];
Tc_8  = [ -9.798184e+01 ; -5.949869e+01 ; 5.895330e+02 ];
omc_error_8 = [ 8.842233e-03 ; 8.680993e-03 ; 1.793499e-02 ];
Tc_error_8  = [ 6.423674e+00 ; 6.088948e+00 ; 6.032171e+00 ];

%-- Image #9:
omc_9 = [ -2.008032e+00 ; -1.953918e+00 ; 4.340570e-01 ];
Tc_9  = [ -7.563414e+01 ; -5.564703e+01 ; 6.384374e+02 ];
omc_error_9 = [ 8.699183e-03 ; 7.129176e-03 ; 1.552239e-02 ];
Tc_error_9  = [ 6.941137e+00 ; 6.567934e+00 ; 6.133768e+00 ];

%-- Image #10:
omc_10 = [ -3.993072e-01 ; -2.793698e+00 ; 6.885182e-01 ];
Tc_10  = [ 2.510305e+01 ; -8.950945e+01 ; 6.482747e+02 ];
omc_error_10 = [ 5.018442e-03 ; 1.062273e-02 ; 1.517297e-02 ];
Tc_error_10  = [ 7.061831e+00 ; 6.666907e+00 ; 6.119155e+00 ];

