addpath('/Users/fatmausta/Dropbox/3DSegmentationCode/metaImage');

patientList = dir(datapath);
ScarVol_array=[];
for i = 1:34
    
    pid = patientList(i+3).name;
    
%volume of GT scar 
         GT=metaImageRead([ datapath '/' pid '/scar-cropped.mhd']); 
         info_scar = metaImageInfo([ datapath '/' pid '/scar-cropped.mhd']);
         voxel_sz_scar=info_scar.ElementSize;
         vol_voxel_scar=voxel_sz_scar(1)*voxel_sz_scar(2)*voxel_sz_scar(3);
         %Scar Volume = sum of number of pixels in scar*voxel_volume
         ScarVol=sum(GT(:))*vol_voxel_scar;
         ScarVol_array=[ScarVol_array ScarVol];
end