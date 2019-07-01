%% Importation of the data and settings
load('s112_ses1_sfinal.mat')
cond = expinfo.condition;
N200_window = 100:300; %research window for N200 estimation
N200_subset = [16 10 4 5 12 19 18 11 6]; %subset of electrodes that are located in the N200 area


%% Plots of the parameters estimation for each condition by averaging across electrodes and trials
par_0 = [1500 200 20 1.5 1500 40]; %first estimation of the parameters

for i=1:6
    subplot(2,6,i);
    N200_m = N200_m_cond(data,cond,i,N200_window,N200_subset);

    par_opt = fminsearch(@(par) norm(F_obj(N200_m',N200_2(par,N200_window),par,N200_window)),par_0,optimset('Display','off'));
    plot(N200_window,N200_m);
    hold on
    plot(N200_window,N200_2(par_opt,N200_window)); 
end    



%% N200 estimations for each condition by averaging across electrodes

for i=1:6
    study = condition_selection(data,cond,i); %selection of condition
    
    N200_est = zeros(size(study,3),2); %stocks the amplitudes and the latencies of the N200s

    for j=1:size(study,3)

        sample = mean(study(N200_window,N200_subset,j),2); %selection of the sample
        par_opt = fminsearch(@(par) norm(F_obj(sample',N200_2(par,N200_window),par,N200_window)),par_0,optimset('Display','off')); %Nelder-Mead simplex
        model = N200_2(par_opt,N200_window); %fitted model
        N200_est(j,:) = N200_estimation(model,N200_window); %estimation of the amplitude and the N200

    end
    N200_est = N200_est(N200_est(:,2)<260,:); %filter excessive outliers (arbitrary value)
    N200_est = N200_est(N200_est(:,2)>140,:); %filter excessive outliers
    
    subplot(2,6,6+i);
    histfit(N200_est(:,2),10,'kernel'); %histogram and density estimation
end


