%Volume based Metrics 
% function [rmse, mad, ave] = Volume_Metrics(vol_GT, vol_Alg)
function [rmse, mad, ave] = Volume_Metrics(vol_GT, vol_CMF, vol_FWHM, vol_STRM, endloop)

rmse = ....rmse_CMF, rmse_FWHM, rmse_STRM
    [sqrt(mean( (vol_GT(:) - vol_CMF(:)).^2 )),....       
    sqrt(mean( (vol_GT(:) - vol_FWHM(:)).^2 )),....
    sqrt(mean( (vol_GT(:) - vol_STRM(:)).^2 ))];

mad =....mae_CMF, mae_FWHM, mae_STRM
    [mean(vol_GT(:) - vol_CMF(:)),....
    mean(vol_GT(:) - vol_FWHM(:)),....
    mean(vol_GT(:) - vol_STRM(:))];

ave =....AVE_CMF, AVE_FWHM, AVE_STRM 
   [abs(vol_GT - vol_CMF)*100/vol_GT,....
   abs(vol_GT - vol_FWHM)*100/vol_GT,....
   abs(vol_GT - vol_STRM)*100/vol_GT];

       
        
         %Absolute Volume Error for CMF     
         
         %You can call it absolute volume error (%) and use the volume (V_algorithm - V_manual)*100/V_manual
%          vol_diff_CMF = GT_Vol - ScarVolCMF;
%          AVE_CMF(i)=abs(vol_diff_CMF)*100/GT_Vol;
%          AVE_CMF_list=[AVE_CMF_list vol_diff_CMF];
%          %Absolute Volume Error for FWHM
%          %You can call it absolute volume error (%) and use the volume (V_algorithm - V_manual)*100/V_manual
%          vol_diff_FWHM = GT_Vol-ScarVolFWHM;
%          AVE_FWHM(i)=abs(vol_diff_FWHM)*100/GT_Vol;
%          AVE_FWHM_list=[AVE_FWHM_list vol_diff_FWHM];
% 
%          %Absolute Volume Error for STRM
%          %You can call it absolute volume error (%) and use the volume (V_algorithm - V_manual)*100/V_manual
%          vol_diff_STRM= GT_Vol - ScarVolSTRM;
%          AVE_STRM(i)=abs(vol_diff_STRM)*100/GT_Vol;
%          AVE_STRM_list=[AVE_STRM_list vol_diff_STRM];
%        

% Root Mean Squared Error
%Calculates Root Mean Squared Error, Mean Squared Error, and Mean Absolute Error 
% vol_GT=[155413.97,59140.168,26598.963,127463.40,124563.48,95069.430,65932.250,125068.01,191079.88,92255.906,88124.906,16641.387,52360.199,153582.42,89248.563,75121.656,59848.984,15447.459,164589.27,118218.32,52070.313,33016.367,143279.25,38318.520,91186.281,69802.164,31320.459,97605.680,99788.930,13162.870,125745.23,135178.73,98698.086,51221.301];
% vol_Alg=[44040.0390625000,28812.2497558594,4085.85937500000,26401.1718750000,19685.8593750000,21116.8750000000,16299.7656250000,18651.4453125000,92113.6328125000,22818.0468750000,13581.4453125000,4218.90625000000,11277.5000000000,40174.5703125000,47110.7812500000,57293.3611410540,23568.5937500000,2363.86718750000,28728.4765625000,59871.0937500000,9988.16406250000,10391.8750000000,47148.8671875000,11771.6015625000,39906.4453125000,25341.3671875000,21896.4990234375,25740.5078125000,30252.4218750000,5904.20487239581,44510.2734375000,39100.5792416198,20106.8359375000,5109.10156250000];
% vol_FWHM=[77612,30674,19106,78942,62346,54724,27752,77604,105983,56830,31748,7436,31638,99224,52590,33228,17026,8286,116842,61256,23160,21956,124068,31738,63338,30542,14682,57094,40076,9926,72524,85730,59822,32684];
% vol_STRM=[181030,97540,156584,231196,169214,174914,152058,182026,194973,156774,296624,278202,155186,188384,157078,163162,201294,224712,189113,203944,353738,70117,188826,73404,146376,127408,99204,141986,156408,79848,170418,184542,157856,126202];


end