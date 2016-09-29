function [uu, erriter, num, tt] = seg_CMF3DLog(img, bg)
%
%   Function test_CMF3D
%
%   The matlab function to show how to use the functions CMF3D_Mex and CMF3D_GPU
%
%   Before using the functions CMF3D_mex, you should compile it as follows:
%       >> mex CMF3D_mex.c
%
%   Before using the functions CMF3D_GPU, you should compile the GPU program:
%       >> nvmex -f nvmexopts.bat CMF3D_GPU.cu -IC:\cuda\v4.0\include -LC:\cuda\v4.0\lib\x64 -lcufft -lcudart
%
%   After compilation, you can define all the parameters (penalty, C_s, C_t, para) as follows: 
%   
%        - penalty: point to the edge-weight penalty parameters to
%                   total-variation function.
% 
%          For the case without incorporating image-edge weights, 
%          penalty is given by the constant everywhere. For the case 
%          with image-edge weights, penalty is given by the pixelwise 
%          weight function:
% 
%          for example, penalty(x) = b/(1 + a*| grad f(x)|) where b,a > 0 .
% 
%        - C_s: point to the capacities of source flows ps
% 
%        - C_t: point to the capacities of sink flows pt
% 
%        - para: a sequence of parameters for the algorithm
%             para[0,1,2]: rows, cols, heights of the given image
%             para[3]: the maximum iteration number
%             para[4]: the error bound for convergence
%             para[5]: cc for the step-size of augmented Lagrangian method
%             para[6]: the step-size for the graident-projection step to the
%                    total-variation function. Its optimal range is [0.1, 0.17].
% 
%
%       Example:
% 
%             >> [u, erriter, i, timet] = CMF3D_GPU(single(penalty), single(Cs), single(Ct), single(para));
%
%             >> us = max(u, beta);  % where beta in (0,1)
%
%             >> figure, loglog(erriter,'DisplayName','erriterN');figure(gcf)
%
%
%   Please email Jing Yuan (cn.yuanjing@gmail.com) for any questions, 
%   suggestions and bug reports
%
%   The Software is provided "as is", without warranty of any kind.
%
%               Version 1.0
%   https://sites.google.com/site/wwwjingyuan/       
%
%   Copyright 2011 Jing Yuan (cn.yuanjing@gmail.com)   
%

Imax = max(img(:));
Imin = min(img(:));
ur = (img - Imin)/(Imax - Imin) ;
   
 [rows,cols,heights] = size(ur);

varParas = [rows; cols; heights; 250; 6e-4; 0.9; 0.1];
%                para 0,1,2 - rows, cols, heights of the given image
%                para 3 - the maximum number of iterations
%                para 4 - the error bound for convergence
%                para 5 - cc for the step-size of augmented Lagrangian method
%                para 6 - the step-size for the graident-projection of p


h = fspecial('gaussian',5, 1);
%img_smooth = imfilter((255*ur),h);
[dx, dy, dz] =gradient(ur);
grad_mag =  (dx.^2 + dy.^2 + dz.^2);
%figure
%isosurface(grad_mag), axis tight, daspect([1 1 1]);

max_grad = max(grad_mag(:));
norm_grad = grad_mag/max_grad;
 alpha(1) = 0.13; alpha(2) = 0.49;  alpha(3) = 3.5;
 penalty = alpha(1) + alpha(2)*exp(-alpha(3)*norm_grad);

%penalty = 0.2*ones(rows, cols, heights);

%ulab(1) = 0.2;
%ulab(2) = 0.6;

load('intPDF_normal');
load('intPDF_scar');


% ulab(1) = 0.1;
% ulab(2) = 0.75;

 ulab(1) = 0.21;
 ulab(2) = 0.55;


CostF = -log(intPDF_scar(floor(255*ur)+1));
minF = min(CostF(:));
maxF = max(CostF(:));

CostF = (CostF - minF)/(maxF-minF);


CostB = -log(intPDF_normal(floor(255*ur)+1));
minB = min(CostB(:));
maxB = max(CostB(:));

CostB = (CostB - minB)/(maxB-minB);

% build up the priori L_2 data terms
%fCs = abs(ur - ulab(1)) -  log(intPDF_normal(floor(255*ur)+1));
%fCt = abs(ur - ulab(2)) - log(intPDF_scar(floor(255*ur)+1));

fCs = CostB;
%fCt = 1.9*CostF;
fCt = 2.0*CostF;
%fCt =  -log(intPDF_scar(floor(255*ur)+1)./ intPDF_normal(floor(255*ur)+1));
%fCs =  -log(intPDF_normal(floor(255*ur)+1)./intPDF_scar(floor(255*ur)+1));

%fCs = fCs/max(fCs(:));
%fCt = fCt/max(fCt(:));

fCt(logical(bg)) = 1e6;
% ----------------------------------------------------------------------
        % ----------------------------------------------------------------------

[uu, erriter,num,tt] = CMF3D_mex(single(penalty), single(fCs), single(fCt), single(varParas));

% ----------------------------------------------------------------------
%  Use the function CMF3D_GPU to run the algorithm on GPU
% ----------------------------------------------------------------------

%[uu, erriter,num,tt] = CMF3D_GPU(single(penalty), single(fCs), single(fCt), single(varParas));