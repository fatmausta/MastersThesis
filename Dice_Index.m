function [DI] = Dice_Index(BW1,BW2)
%  Dice Coefficient calculation
BW1=double(BW1);
BW2=double(BW2);
t= (BW1.*BW2);%logical and operation. element wise multiplication
InSec=sum(t(:));
DI=2*InSec/(sum(BW1(:))+sum(BW2(:)));