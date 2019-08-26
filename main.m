%% Recovering of parameters on artificial data with the first model (obsolete)

%Mean values
means = [ 3 200 80 1 300 50 0.8 750 100]';

%Simplex directions
dir = [0.2 50 20 0.2 50 20 0.2 50 30];

%Standard errors
se = [0.3 20 8 0.1 40 5 0.08 90 10];


x = linspace(-500, 1500, 4001);


%% Generate an EEG data set centered on the means (Gaussian distribution)
rng(123);
n=100; %number of EEGs generated
[data,par] = generate_data(n,means,se,x);

%% Estimation of the means by Maximum-Likelihood and Nelder-Mead Simplex
par_opt = zeros(n,length(means));
best_alpha = 0.91;


for i=1:n
    par_opt(i,:) = NM(means,dir,x,data(i,:),best_alpha,3);
end

[mu_hat,sigma_hat] = mle(par_opt);

figure
hold on
plot_EEG(mu_hat,x);
plot_EEG(means,x);