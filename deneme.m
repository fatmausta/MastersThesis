info=[];
for i=1:34

pid = patientList(i+2).name;
patientList = dir('C:\Users\fatmausta-admin\Documents\MATLAB\LV');
info = [ info metaImageInfo(['C:\Users\fatmausta-admin\Documents\MATLAB\LV/' pid '/FU_Results/' 'LGE-cropped-iso.mhd'])];

end