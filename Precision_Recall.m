%precision and ercall
function[precision,recall]=Precision_Recall(GT,Algo)
tp(:)=(GT(:)==1 & Algo(:)==1);
fp(:)=(GT(:)==0 & Algo(:)==1);
fn(:)=(GT(:)==1 & Algo(:)==0);

n_tp=sum(tp(:));
n_fp=sum(fp(:));
n_fn=sum(fn(:));

%precision 
precision=n_tp/(n_tp+n_fp);
%recall
recall=n_tp/(n_tp+n_fn);
