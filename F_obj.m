function [F] = F_obj(EEG,model)
F = (EEG - model)';
end