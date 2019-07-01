function [N200_m] = N200_m_cond(data,cond,ind,N200_window,N200_subset)
    study = condition_selection(data,cond,ind); %selection of condition
    N200_me = mean(study(N200_window,N200_subset,:),2); %mean across the electrodes
    N200_m = mean(squeeze(N200_me),2); % mean across electrodes and trials
end