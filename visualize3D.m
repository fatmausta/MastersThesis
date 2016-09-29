%isosurface_CMF
function []=visualize3D(GTA, uu, FWHM, STRM)

  %cmf
        figure;
        isosurface(uu,0.5), axis tight, daspect([1 1 1]);
        camlight;
        hold on;
        %view automatically resulted data as red
        pa = patch(isosurface(GTA,0.3)); 
        pa.FaceColor = 'red';pa.EdgeColor = 'none';
        daspect([1 1 1]);axis tight;camlight;alpha(0.45);%transparent isosurface
        legend('Ground Truth','CMF');

        %fwhm
        figure
        isosurface(FWHM,0.5), axis tight, daspect([1 1 1]);
        camlight;
        hold on;
        %view automatically resulted data as red
        pa = patch(isosurface(GTA,0.3)); 
        pa.FaceColor = 'yellow';pa.EdgeColor = 'none';
        daspect([1 1 1]);axis tight;camlight;alpha(0.45);%transparent isosurface
        legend('Ground Truth','FWHM');

        %strm
        figure
        isosurface(STRM,0.5), axis tight, daspect([1 1 1]);
        camlight;
        hold on;
        %view automatically resulted data as red
        pa = patch(isosurface(GTA,0.3)); 
        pa.FaceColor = 'blue';pa.EdgeColor = 'none';
        daspect([1 1 1]);axis tight;camlight;alpha(0.45);%transparent isosurface
        legend('Ground Truth','STRM');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%