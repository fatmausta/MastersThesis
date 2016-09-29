function [STRM_Scar] = STRM(img, bg)

Imax = max(img(:));
Imin = min(img(:));
ur = (img - Imin)/(Imax - Imin)*255 ;

%after normalization, STRM    
    Reference_Mean=mean(ur(:))+3*std(ur(:));
    STRM_Scar=(ur>Reference_Mean);