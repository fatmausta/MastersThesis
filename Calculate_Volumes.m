function [vol_GT, vol_CMF, vol_FWHM, vol_STRM] = Calculate_Volumes(info, GTA, CMF_Scar, FWHM_Scar, STRM_Scar)
       
    %order of volume
    %imgA, myoA, GTA, Scar_CMF, Scar_FWHM, Scar_STRM 
    
%         AVE_CMF_list=[];
%         AVE_FWHM_list=[];
%         AVE_STRM_list=[];
%         ScarVol_FWHM_array=[];
%         MyoVolArray=[];
%         ScarVol_STRM_array=[];
%         ScarVol_GT_array=[];
% 
%    
         
        %%%%%%%%%%%%%%%%%%%%%
%          %1) volume of ground truth tissue :
% %        info_scar = metaImageInfo([datapath '/' pid '/FU_Results/' 'scar-CMF.mhd']);
%          voxel_size=info(1).ElementSize;
%          voxel_vol=voxel_size(1)*voxel_size(2)*voxel_size(3);
%          %Normal Volume = sum of number of pixels in normal*voxel_volume,
%          % normal is found as all - scar number of pixels
%          
%          vol_GT=sum(CMF_Scar(:))*voxel_vol;
%          vol_GTA=[vol_GTA vol_GT];
%          
%          
%          %2) volume of normal mocardium tissue :
% %          info_scar = metaImageInfo([datapath '/' pid '/FU_Results/' 'scar-CMF.mhd']);
%          voxel_size=info(2).ElementSize;
%          voxel_vol=voxel_size(1)*voxel_size(2)*voxel_size(3);
%          %Normal Volume = sum of number of pixels in normal*voxel_volume,
%          % normal is found as all - scar number of pixels
%          
%          vol_CMF=sum(CMF_Scar(:))*voxel_vol;
%          vol_CMFA=[vol_CMFA vol_CMF];
%          
         % 3) volume of GT:
%        info_GTA = metaImageInfo([ datapath '/' pid '/' 'scar-cropped.mhd']);
         voxel_size=info(3).ElementSize;
         voxel_vol=voxel_size(1)*voxel_size(2)*voxel_size(3);
         %GT scar Volume = sum of number of pixels in GT*voxel_volume
         vol_GT = sum(GTA(:))*voxel_vol;
%          vol_GTA=[vol_GTA vol_GT];
         
         
          %4) volume of CMF scar resulted by CMF:
%          info_scar = metaImageInfo([datapath '/' pid '/FU_Results/' 'scar-CMF.mhd']);
         voxel_size=info(4).ElementSize;%element size is voxel sizes x, y, z
         voxel_vol=voxel_size(1)*voxel_size(2)*voxel_size(3);
         %Scar Volume = sum of number of pixels in scar*voxel_volume
         vol_CMF=sum(CMF_Scar(:))*voxel_vol;
%          vol_CMFA=[vol_CMFA vol_CMF];
         
         %5)volume of FWHM scar:
         
%        info_FWHM_scar = metaImageInfo([ datapath '/' pid '/FU_Results/' 'FWHM_scar.mhd']);
         voxel_size=info(5).ElementSize;
         voxel_vol=voxel_size(1)*voxel_size(2)*voxel_size(3);
         %Scar Volume = sum of number of pixels in scar*voxel_volume
         vol_FWHM=sum(FWHM_Scar(:))*voxel_vol;
%          vol_FWHMA=[vol_FWHMA vol_FWHM];

         %6) volume of STRM scar:
%         info_STRM_scar = metaImageInfo([ datapath '/' pid '/FU_Results/' 'STRM_scar.mhd']);
         voxel_size=info(6).ElementSize;
         voxel_vol=voxel_size(1)*voxel_size(2)*voxel_size(3);
         %Scar Volume = sum of number of pixels in scar*voxel_volume
         vol_STRM=sum(STRM_Scar(:))*voxel_vol;
%          vol_STRMA=[vol_STRMA vol_STRM];

         end
