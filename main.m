clear all;
close all;
patientList = dir('/Users/fatmausta/Desktop/RESEARCH/3D/LV');
addpath('~/Documents/MATLAB/metaImage');
dice=[];
for i = 1:34
    
    pid = patientList(i+3).name;

    % Loading the previously segmented myocardium boundary
 
    info = metaImageInfo(['/Users/fatmausta/Desktop/RESEARCH/3D/LV/' pid '/' 'myo-cropped.mhd']);
    myo  = metaImageRead(info);
  %   [y, x, z]= meshgrid(1:1:size(myo,1),1:1:size(myo,2),1:0.5:size(myo,3));
  %   myoA=interp3(myo,y,x,z,'nearest');
    
    % Loading the image

    info2 = metaImageInfo(['/Users/fatmausta/Desktop/RESEARCH/3D/LV/'  pid '/' pid '-LGE-cropped.mhd']);
    img = metaImageRead(info2);
        
     imgA = img;
 %   imgA=interp3(img,y,x,z,'nearest');
    
    % Loading the ground truth

    info3=metaImageInfo(['/Users/fatmausta/Desktop/RESEARCH/3D/LV/' pid '/' 'scar-cropped.mhd']);
    GT = (metaImageRead(info3));%    GTA=interp3(GT,y,x,z,'nearest');
    GTA= smooth3(double(GT),'gaussian',5,2);
    GTA = GTA > 0.49;
    %metaImageWrite(uint8(GTA>0.5), ['LV/' pid '/' 'scar-cropped-smooth.mhd']);
    GTA= imfill(GTA,'holes');
    
    cimg = double(myo).*double(imgA);
    
     bg = 1 - double(myo);
    [uu, erriter, num, tt] = seg_CMF3DLog(cimg, bg);
    
    GTA = GTA  .* double(myo);
    
%     dice(i) = Dice_Index(uu>0.49,logical(GTA))
    dice = [dice Dice_Index(uu>0.49,logical(GTA))];
    %figure;isosurface(uu,0.5), axis image, daspect([1 1 2]);
    %figure;isosurface(GT,0.5), axis image, daspect([1 1 2]);
    %figure;isosurface(uu,0.5), axis image, daspect([1 1 2]);
    %figure;isosurface(GT,0.5), axis image, daspect([1 1 2]);
    %metaImageWrite(int8(uu>0.5),['LV/' pid '/' 'scar-CMF.mhd']);
    
   
    % Volume Calculation
    v_gt(i)  = nnz(GTA) * info.ElementSize(1)* info.ElementSize(2) * info.ElementSize(3);
    v_cmf(i) = nnz(uu>0.49) * info.ElementSize(1)* info.ElementSize(2) * info.ElementSize(3);
    

end

meanDice = mean(dice);
stdDice = std(dice);
display(['Mean Dice:' num2str(meanDice)]);
display(['Mean Dice std:' num2str(stdDice)]);
