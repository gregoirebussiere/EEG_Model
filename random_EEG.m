%% Greneration of random EEG
function [EEG,par] = random_EEG(means,se,x)

    %Generate an EEG according to a Gaussian distribution on the parameters

    par = generate_parameters(means,se); 
    N200 = generate_N200(par(1:3),x);
    P300 = generate_P300(par(4:6),x);
    RP = generate_RP(par(7:9),x);
    gau_noise = 1/15 * randn(size(x));

    EEG = N200 + P300 + RP + gau_noise;
end