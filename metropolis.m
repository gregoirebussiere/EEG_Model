%% Metropolis algorithm to estimate the parameters of the model

%Run N200 fitting previously to load the data and the selection of the
%trials

rng(0) %reproductibility of the results
study = condition_selection(eeg.stimlocked.sterp,eeg.expinfo.condition,4); %condition selection (here i=4)
goodtrials = study(:,accept(241:320)==1);%select good trials of this condition ((i-1)*80+1:i*80)
sample = goodtrials(:,16);%selection of a particular trial (here = 16)

n_chains = 1; %number of chains generated

iter = 20000; %length of the chain
burn_in = 10000; %length of the burn-in period

%Prior distribution (Gaussians)
mu_prior = [150000 205 50 0 200000 60]; 
sigma_prior = [75000 20 15 10 100000 15];

%Kernel parameters (Gaussian)
sigma_ker = [1000 2 0.7 0.1 1000 0.7];
var = 0.05 * ones(length(sample),1);

par_mu = zeros(n_chains,6);

%% Metropolis algorithm
for k=1:n_chains
    
    theta = normrnd(mu_prior,sigma_prior); %Initialization
    
    R_theta = F_pen(sample',N200_2(theta,window),theta,window); %Weighted residuals
    log_L_theta = log_likelihood(R_theta,var); %log-likelihood
    log_post_theta = log_L_theta + log(prod(prior(theta,mu_prior,sigma_prior))); %log-posterior

    B = zeros(burn_in,6); %burn-in parameters
    L_B = zeros(burn_in,1); %burn-in log-likelihood


    for i=1:burn_in %burn-in
        phi = transition_kernel(theta,sigma_ker); %candidate
        R_phi = F_pen(sample',N200_2(phi,window),phi,window);
        log_L_phi = log_likelihood(R_phi,var);
        log_post_phi = log_L_phi + log(prod(prior(phi,mu_prior,sigma_prior)));
        alpha = log_post_phi - log_post_theta;
        if (log(rand) < alpha) %Test of acceptation
            theta = phi;
            log_post_theta = log_post_phi;
        end
        B(i,:) = theta;
        L_B(i) = log_post_theta;
    end

    D = zeros(iter,6);
    L = zeros(iter,1);

    p=0;

    for i=1:iter %chain
        phi = transition_kernel(theta,sigma_ker); %candidate
        R_phi = F_pen(sample',N200_2(phi,window),phi,window);
        log_L_phi = log_likelihood(R_phi,var);
        log_post_phi = log_L_phi + log(prod(prior(phi,mu_prior,sigma_prior)));
        alpha = log_post_phi - log_post_theta;
        if (log(rand) < alpha) %Test of acceptation
            p = p+1;
            theta = phi;
            log_post_theta = log_post_phi;
        end
        D(i,:) = theta;
        L(i) = log_post_theta;    
    end

    acceptance_rate = p/iter
    
    
    %% Plots of the results
    figure
    for l=1:6 
        subplot(7,1,l)
        plot(1:burn_in,B(:,l),'red',burn_in+1:burn_in+iter,D(:,l),'blue')
        ylabel(strcat('\theta(',sprintf('%d',l),')'))
    end
    subplot(7,1,7)
    plot(1:burn_in,L_B,'red',burn_in+1:burn_in+iter,L,'blue')
    ylabel('L')
    xlabel('Iterations')

    figure
    for j=1:6
        subplot(2,3,j)
        hist(D(:,j),15)
        histfit(D(:,j),15,'normal')
        xlabel(strcat('\theta(',sprintf('%d',j),')'))
        ylabel('Frequency')
        norm_par = fitdist(D(:,j),'normal');
        par_mu(k,j) = norm_par.mu;
    end
    
end




%% Curve fitting observation and chains comparison
figure
plot(window,sample)
par_opt = fminsearch(@(par) norm(F_pen(sample',N200_2(par,window),par,window)),par_0,optimset('Display','off'));
par_mu;
hold on
plot(window,N200_2(par_opt,window))
xlabel('Time(ms)')
ylabel('Amplitude')
for m=1:n_chains
    plot(window,N200_2(par_mu(m,:),window))
end