function [FWHM_Scar] = FWHM(img, bg)

Imax = max(img(:));
Imin = min(img(:));
ur = (img - Imin)/(Imax - Imin)*255 ;

%after normalization, FWHM
    half_max=max(ur(:))/2;
    FWHM_Scar=(ur>half_max);