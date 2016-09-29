function [myo,img,GT]=Load3Dimages(pid, datapath, codepath);
 
%      info = metaImageInfo(['/Users/fatmausta/Desktop/RESEARCH/3D/LV/' pid '/' 'myo-cropped.mhd']);
%      myo  = metaImageRead(info);
 addpath('/Users/fatmausta/Dropbox/3DSegmentationCode/metaImage');

addpath(datapath);
addpath(codepath);
     info = metaImageInfo([datapath '/' pid '/' 'myo-cropped.mhd']);
     myo  = metaImageRead(info);
    % Loading the image
    info2 = metaImageInfo([datapath '/'  pid '/' pid '-LGE-cropped.mhd']);
    img = metaImageRead(info2);
      
    % Loading the ground truth
    info3=metaImageInfo([datapath '/' pid '/' 'scar-cropped.mhd']);
    GT = (metaImageRead(info3));