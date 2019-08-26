%% Calculate the residuals (Obsolete)
function [F] = F_obj(EEG,model)
F = (EEG-model)';
% F = F(max(1,ceil(par(2)-sqrt(3)*par(3)-N200_window(1))):min(length(N200_window),floor(par(2)+sqrt(3)*par(3)-N200_window(1))));
end