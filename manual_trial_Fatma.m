%Fatma Manual trial
close all
clear all
% patientList = dir('C:\Users\fatmausta-admin\Documents\MATLAB\LV');
% addpath('C:\Users\fatmausta-admin\Dropbox\3DSegmentationCode\metaImage');
addpath('/Users/fatmausta/Documents/RESEARCH/3D/LV/');
% addpath('/Users/fatmausta/Dropbox/3DSegmentationCode\metaImage');
addpath('/Users/fatmausta/Documents/MATLAB/metaImage');

% pathAlg=
% pathCMF=
info  = metaImageInfo('C:\Users\fatmausta-admin\Dropbox\ManualTrial\0546\0546_FU_Manual_2.mhd');
% info= metaImageInfo('/Users/fatmausta/Dropbox/ManualTrial/0515/0515_FU_Manual_2.mhd');
scar  = metaImageRead(info);

info3=metaImageInfo('C:\Users\fatmausta-admin\Documents\MATLAB\LV\0546\scar-cropped.mhd');
%info3=metaImageInfo('/Users/fatmausta/Documents/MATLAB/Cardiacdata/0515/scar-cropped.mhd');
%sometimes iso, sometimes normak scar-cropped is used. dimensionality
%mismatch

GT = (metaImageRead(info3));
    
dice = Dice_Index(logical(scar),logical(GT))
