%Absolute VOlume Error
%You can call it absolute volume error (%) and use the volume (V_algorithm - V_manual)*100/V_manual

    
%     %volume of scar and GT
%     %volume of a voxel  is ( size of a voxel= element size )
%     voxel_size = info.ElementSize;
%     %volume of one voxel in mm
%     vol_voxel=voxel_size(1)*voxel_size(2)*voxel_size(3);
%      
    
     %volume of scar:
     metaImageWrite(int8(uu>0.5),['/Users/fatmausta/Desktop/RESEARCH/3D/LV/' pid '/' 'scar-CMF-B.mhd']); 
     info_scar = metaImageInfo(['/Users/fatmausta/Desktop/RESEARCH/3D/LV/' pid '/' 'scar-CMF-B.mhd']);
     voxel_sz_scar=info_scar.ElementSize;
     vol_voxel_scar=voxel_sz_scar(1)*voxel_sz_scar(2)*voxel_sz_scar(3);
     %Scar Volume = sum of number of pixels in scar*voxel_volume
     ScarVol=sum(uu(:))*vol_voxel_scar;
     
     %volume of FWHM scar:
     metaImageWrite(int8(FWHM_Scar>0.5),['/Users/fatmausta/Desktop/RESEARCH/3D/LV/' pid '/' 'FWHM_scar.mhd']); 
     info_FWHM_scar = metaImageInfo(['/Users/fatmausta/Desktop/RESEARCH/3D/LV/' pid '/' 'FWHM_scar.mhd']);
     voxel_sz_FWHM_scar=info_FWHM_scar.ElementSize;
     vol_voxel_FWHM_scar=voxel_sz_FWHM_scar(1)*voxel_sz_FWHM_scar(2)*voxel_sz_FWHM_scar(3);
     %Scar Volume = sum of number of pixels in scar*voxel_volume
     ScarVolFWHM=sum(FWHM_Scar(:))*vol_voxel_FWHM_scar;
     
     %volume of GT:
     info_GTA = info3; %info3=metaImageInfo(['/Users/fatmausta/Desktop/RESEARCH/3D/LV/' pid '/' 'scar-cropped.mhd']);
     voxel_sz_scar=info_GTA.ElementSize;
     vol_voxel_GTA=voxel_sz_scar(1)*voxel_sz_scar(2)*voxel_sz_scar(3);
     %GT scar Volume = sum of number of pixels in GT*voxel_volume
     GT_Vol=sum(GTA(:))*vol_voxel_GTA;
     
     %Absolute Volume Error for CMF
     %You can call it absolute volume error (%) and use the volume (V_algorithm - V_manual)*100/V_manual
     vol_diff=GT_Vol-ScarVol;
     AVE_CMF(i)=vol_diff*100/ScarVol;

     
     %Absolute Volume Error for FWHM
     %You can call it absolute volume error (%) and use the volume (V_algorithm - V_manual)*100/V_manual
     vol_diff_FWHM=GT_Vol-ScarVolFWHM;
     AVE_FWHM(i)=vol_diff_FWHM*100/ScarVolFWHM;
     
%      %Volumetric Distance (VD) = 
%      % ( absolute volume difference ) / (sum of compared volumes )
%      
%      %volume difference for CMF
%      vol_diff=GT_Vol-ScarVol;
%      vol_sum=GT_Vol+ScarVol;
%      abs_vol= abs(vol_diff);
%      %Volumetric Distance for CMF
%      VD(i)=abs_vol / vol_sum;
     
%      
%      %volume difference for FWHM
%      vol_diff_FWHM=GT_Vol-ScarVolFWHM;
%      vol_sum_FWHM=GT_Vol+ScarVolFWHM;
%      abs_vol_FWHM= abs(vol_diff_FWHM);
%      %Volumetric Distance FOR FWHM
%      VD_FWHM(i)=abs_vol_FWHM / vol_sum_FWHM;
%      
