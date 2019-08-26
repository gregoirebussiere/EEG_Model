%% Objective function with Gaussian weights
function [F] = F_pen(EEG,model,par,N200_window)
    w = normpdf(N200_window,par(2),100);
    F = (EEG-model)';
    F = F .* w';
end