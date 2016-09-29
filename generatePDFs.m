patientList = dir('/Users/fatmausta/Desktop/RESEARCH/3D/LV');
addpath('/Users/fatmausta/Desktop/RESEARCH/3D/metaImage');


for i = 1:20
    
    pid = patientList(i+3).name;
    % Loading the previously segmented myocardium boundary
    myo = double(metaImageRead(['/Users/fatmausta/Desktop/RESEARCH/3D/LV/' pid '/' 'myo-cropped.mhd']));
    
    % Loading the image
    img = double(metaImageRead(['/Users/fatmausta/Desktop/RESEARCH/3D/LV/' pid '/' pid '-LGE-cropped.mhd']));
    
    
    % Loading the ground truth
    GT = double(metaImageRead(['/Users/fatmausta/Desktop/RESEARCH/3D/LV/' pid '/' 'scar-cropped.mhd']));
    
    cimg = myo.*img;
    Imax = max(cimg(:));
    Imin = min(cimg(:));
    img = 255*(cimg - Imin)/(Imax - Imin) ;
    
    samples = 0:1:255;
    
    IntScar{i}    = img(logical(GT));
    normalMyo  = myo - GT;
    IntNormal{i} = img(logical(normalMyo));
    
    
end



IntsScar = cell2mat(IntScar');
IntsNormal = cell2mat(IntNormal');

intPDF_scar   = ksdensity(double(IntsScar),samples,'Width',7);
intPDF_normal = ksdensity(double(IntsNormal),samples,'Width',7);

for j = 1:12
   intPDF_scar(j) = 0.0001; 
end

save('intPDF_scar','intPDF_scar');
save('intPDF_normal','intPDF_normal');

figure; plot(intPDF_scar); hold on; plot(intPDF_normal,'r');
hold off;
