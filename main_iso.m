close all;
clear all;
endloop=0;
datapath='C:\Users\fatmausta-admin\Documents\MATLAB\LV';
codepath='C:\Users\fatmausta-admin\Dropbox\3DSegmentationCode\metaImage';

% datapath='/Users/fatmausta/Documents/MATLAB/LV';
% codepath='/Users/fatmausta/Dropbox/3DSegmentationCode';

% patientList = dir('/Users/fatmausta/Desktop/RESEARCH/3D/LV');
% addpath('/Users/fatmausta/Desktop/RESEARCH/3D');
 addpath('/Users/fatmausta/Dropbox/3DSegmentationCode/metaImage');

patientList = dir(datapath);
% addpath('C:\Users\fatmausta\Dropbox\3DSegmentationCode\metaImage');
addpath(datapath);
addpath(codepath);

vol_GTA=[];
vol_CMFA=[];
vol_FWHMA=[];
vol_STRMA=[];

    for i = 1:4 %34

        pid = patientList(i+2).name;

        [myo,img,GT]=Load3Dimages(pid, datapath, codepath);
    
    [y, x, z]= meshgrid(1:1:size(myo,1),1:1:size(myo,2),1:0.5:size(myo,3));
     myoA=interp3(myo,y,x,z,'nearest');
    
     %imgA = img;
    imgA=interp3(img,y,x,z,'nearest');
    
    GTA=interp3(GT,y,x,z,'nearest');
    GTA= smooth3(double(GTA),'gaussian',5,2);
    GTA = GTA > 0.49;
    
    GTA= imfill(GTA,'holes');
    
    cimg = double(myoA).*double(imgA);
    
    bg = 1 - double(myoA);
     
     FWHM_Scar=FWHM(cimg, bg);
     STRM_Scar=STRM(cimg, bg);
     
    [CMF_Scar, erriter, num, tt] = seg_CMF3DLog(cimg, bg);
    
    GTA = GTA  .* double(myoA);
    
    dice_CMF(i) = Dice_Index(CMF_Scar>0.49,logical(GTA))  
    dice_FWHM(i) = Dice_Index(FWHM_Scar>0.49,logical(GTA))
    dice_STRM(i) = Dice_Index(STRM_Scar,logical(GTA));
    
    %save the interpolated images
   %imgA, myoA, GTA, Scar_CMF, Scar_FWHM, Scar_STRM 
    info=[....
    metaImageInfo([datapath '/' pid '/FU_Results/' 'LGE-cropped-iso.mhd']),....
    metaImageInfo([datapath '/' pid '/FU_Results/' 'myo-cropped-iso.mhd']),....   
    metaImageInfo([datapath '/' pid '/FU_Results/' 'scar-cropped-iso.mhd']),....
    metaImageInfo([datapath '/' pid '/FU_Results/' 'scar-CMF-iso.mhd']), ....
    metaImageInfo([datapath '/' pid '/FU_Results/' 'STRM_scar-iso.mhd']),....
    metaImageInfo([datapath '/' pid '/FU_Results/' 'FWHM_scar-iso.mhd'])];
    
%     metaImageWrite(info(1));
%     metaImageWrite(info(2));
%     metaImageWrite(info(3));
%     metaImageWrite(info(4));
%     metaImageWrite(info(5));
%     metaImageWrite(info(6));
% 
%     metaImageWrite(uint8(imgA), [datapath '/' pid '/FU_Results/' 'LGE-cropped-iso.mhd'],....
%     metaImageWrite(uint8(myoA), [datapath '/' pid '/FU_Results/' 'myo-cropped-iso.mhd']),....   
%     metaImageWrite(uint8(GTA>0.5), [datapath '/' pid '/FU_Results/' 'scar-cropped-iso.mhd']),....
%     metaImageWrite(int8(CMF_Scar>0.5),[ datapath '/' pid '/FU_Results/' 'scar-CMF-iso.mhd']), ....
%     metaImageWrite(int8(STRM_Scar>0.5),[ datapath '/' pid '/FU_Results/' 'STRM_scar-iso.mhd']),....
%     metaImageWrite(int8(FWHM_Scar>0.5),[ datapath '/' pid '/FU_Results/' 'FWHM_scar-iso.mhd'])

    %%%%%%%%%%%%%%%%%%%
    %VOLUME METRICS COMPUTATION
    [vol_GT, vol_CMF, vol_FWHM, vol_STRM] = Calculate_Volumes (info, GTA, CMF_Scar, FWHM_Scar, STRM_Scar);
   
    vol_GTA=[vol_GTA vol_GT];
    vol_CMFA=[vol_CMFA vol_CMF];
    vol_FWHMA=[vol_FWHMA vol_FWHM];
    vol_STRMA=[vol_STRMA vol_STRM];
     
    [rmse, mad, ave]= Volume_Metrics (vol_GT, vol_CMF, vol_FWHM, vol_STRM, endloop);

   %$%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%$%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
   %visualizing the results
        
      %visualize3D(GTA,uu, FWHM_Scar, STRM_Scar);
    end

 
% display_results(GTA, CMF_Scar, FWHM_Scar, STRM_Scar, dice_CMF, dice_FWHM, dice_STRM, AVE_CMF, AVE_FWHM, AVE_STRM);

dice1=transpose(dice_CMF);
dice2=transpose(dice_FWHM);
dice3=transpose(dice_STRM);

if(i>1) 
figure
boxplot([dice1,dice2,dice3],'Labels',{['CMF dice:' num2str(mean(dice1)) ],...
    ['FWHM dice:' num2str(mean(dice2)) ] ,[ 'STRM dice:' num2str(mean(dice3)) ] });
title('Dice Accuracy of CMF, FWHM and STRM');
% 
% AVE1=AVE_CMF;
% AVE2=AVE_FWHM;
% AVE3=AVE_STRM;

% AVE1=transpose(AVE_CMF);
% AVE2=transpose(AVE_FWHM);
% AVE3=transpose(AVE_STRM);

figure
boxplot([transpose(ave(1)),transpose(ave(2)),transpose(ave(3))],'Labels',{['CMF |VE|:' num2str(mean(transpose(ave(1)))) ],...
    ['FWHM |VE|:' num2str(mean(transpose(ave(2)))) ] ,[ 'STRM |VE|:' num2str(mean(transpose(ave(3)))) ] });
title('Absolute Volume Error of CMF, FWHM and STRM');

%boxplots for 
end