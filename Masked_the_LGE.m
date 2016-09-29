clear all;
 datapath='C:\Users\fatmausta-admin\Documents\MATLAB\LVSub3';
% datapath='C:\Users\fatmausta-admin\Dropbox\ManualTrial\maskedIMG';
% addpath('/Users/fatmausta/Dropbox/3DSegmentationCode/metaImage');
addpath('C:\Users\fatmausta-admin\Dropbox\3DSegmentationCode\metaImage');

patientList = dir(datapath);
% addpath('C:\Users\fatmausta\Dropbox\3DSegmentationCode\metaImage');
addpath(datapath);

for i = 1:5 %3
    pid = patientList(i+2).name;
    info = metaImageInfo([datapath '/' pid '/' 'myo-cropped.mhd']);
    myo  = metaImageRead(info);
    myo=int16(myo);
    % Loading the image
%     info2 = metaImageInfo([datapath '/'  pid '/' pid '-LGE-cropped.mhd']);
    info2 = metaImageInfo([datapath '/'  pid '/' pid '-MRA-cropped.mhd']);
    img = metaImageRead(info2);
    img=int16(img);
    maskedimg=img.*myo;
    
%     metaImageWrite(maskedimg, [datapath '/' pid '/' pid '-MRA_masked.mhd']);
% metaImageWrite(maskedimg, [datapath '/maskedIMG' '/' pid '-MRA_masked.mhd']);
 metaImageWrite(maskedimg, ['C:\Users\fatmausta-admin\Dropbox\ManualTrial\maskedIMG' '/' pid '-MRA_masked.mhd']);
    end