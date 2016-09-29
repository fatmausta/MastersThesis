patientList = dir('LV');
addpath('~/Documents/MATLAB/metaImage');

for i = 1:34
    load('roipoints.mat');
    pid = patientList(i+2).name;
    % Loading the previously segmented myocardium boundary
    img = (metaImageRead(['LV/' pid '/' pid '-LGE-cropped.mhd']));
    x = p(i,1);
    y = p(i,2);
    z = p(i,3);
    
    Imax = max(double(img(:)));
    Imin = min(double(img(:)));
    
    img = 255*(double(img) - Imin) / (Imax - Imin);
    
    n = 6;
    roi = double(img(y-n:y+n,x-n:x+n,z-4:z+4));
    
    myo = (metaImageRead(['LV/' pid '/' 'myo-cropped.mhd']));
    
    Std = std(roi(:));
    Mean = mean(roi(:));
    
    thres = Mean + 8 * Std;
    
      % Loading the ground truth
    GT = (metaImageRead(['LV/' pid '/' 'scar-cropped.mhd']));
%    GTA=interp3(GT,y,x,z,'nearest');
    GTA= smooth3(double(GT),'gaussian',5,2);
    GTA = GTA > 0.49;
    %metaImageWrite(uint8(GTA>0.5), ['LV/' pid '/' 'scar-cropped-smooth.mhd']);
    GTA= imfill(GTA,'holes');
    
    
    
    cimg = double(myo).*double(img);
    
    uu = cimg > thres;
    
    GTA = GTA  .* double(myo);
    
    
    Size(i) = nnz(GTA);
    
    dice(i) = Dice_Index(uu>0.49,logical(GTA))
    
    
    
end