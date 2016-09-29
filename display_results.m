%computing metrics
function [] = display_results(GTA, uu, FWHM_Scar, STRM_Scar, dice, dice_FWHM, dice_STRM, AVE_CMF, AVE_FWHM, AVE_STRM)
%precision 
[precision_CMF,recall_CMF]=Precision_Recall(GTA,uu);
[precision_FWHM,recall_FWHM]=Precision_Recall(GTA,FWHM_Scar);
[precision_STRM,recall_STRM]=Precision_Recall(GTA,STRM_Scar);

meanDice = mean(dice);
stdDice = std(dice);
display(['Mean CMF Dice:' num2str(meanDice)]);
display(['Mean CMF Dice std:' num2str(stdDice)]);

meanDice_FWHM = mean(dice_FWHM);
stdDice_FWHM = std(dice_FWHM);
display(['Mean FWHM Dice:' num2str(meanDice_FWHM)]);
display(['Mean FWHM Dice std:' num2str(stdDice_FWHM)]);

meanDice_STRM = mean(dice_STRM);
stdDice_STRM = std(dice_STRM);
display(['Mean STRM Dice:' num2str(meanDice_STRM)]);
display(['Mean STRM Dice std:' num2str(stdDice_STRM)]);

meanAVE = mean(AVE_CMF);
stdAVE = std(AVE_CMF);
display(['Mean CMF AVE:' num2str(meanAVE)]);
display(['Mean CMF AVE std:' num2str(stdAVE)]);

meanAVE_FWHM = mean(AVE_FWHM);
stdAVE_FWHM = std(AVE_FWHM);
display(['Mean FWHM AVE:' num2str(meanAVE_FWHM)]);
display(['Mean FWHM AVE std:' num2str(stdAVE_FWHM)]);

meanAVE_STRM = mean(AVE_STRM);
stdAVE_STRM = std(AVE_STRM);
display(['Mean STRM AVE:' num2str(meanAVE_STRM)]);
display(['Mean STRM AVE std:' num2str(stdAVE_STRM)]);


end