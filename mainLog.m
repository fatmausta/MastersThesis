
patientList = dir('LV');
addpath('~/Documents/MATLAB/metaImage');


for i = 1:34
    
    pid = patientList(i+2).name;
    % Loading the previously segmented myocardium boundary
    myo = double(metaImageRead(['LV/' pid '/' 'myo-cropped.mhd']));
    
    % Loading the image
    img = double(metaImageRead(['LV/' pid '/' pid '-LGE-cropped.mhd']));
    
    
    % Loading the ground truth
    GT = double(metaImageRead(['LV/' pid '/' 'scar-cropped.mhd']));
    
    % Smoothing GT
    GTS= smooth3(GT,'gaussian',5,3);
    metaImageWrite(uint8(GTS>0.5), ['LV/' pid '/' 'scar-cropped-smooth.mhd']);
    
    cimg = myo.*img;
    
    bg = 1 - myo;
 
    [uu, erriter, num, tt] = seg_CMF3DLog(cimg, bg);
    
    dice(i) = Dice_Index(uu>=0.5,(GTS>0.5))
    
%   figure;isosurface(uu,0.5), axis image, daspect([1 1 2]);axis off;
%   figure;isosurface(GT,0.5), axis image, daspect([1 1 2]);axis off;
       %figure;isosurface(uu,0.5), axis image, daspect([1 1 2]);
    %figure;isosurface(GT,0.5), axis image, daspect([1 1 2]);
    metaImageWrite(int8(uu>0.5),['LV/' pid '/' 'scar-CMF.mhd']);
    
end

meanDice = mean(dice);
display(['Mean Dice:' num2str(meanDice)]);

