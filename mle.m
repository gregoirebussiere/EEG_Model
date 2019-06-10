%% Maximum-likelihood estimation of the EEG parameters
function [mu_hat,sigma_hat] = mle(par_opt)
    %par_opt: matrix of estimated parameters on random EEGs

    mu_hat = mean(par_opt);
    sigma_hat = sqrt(mean((par_opt - repmat(mu_hat,length(par_opt),1)).^2));
end