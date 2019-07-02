%% Importation of the data and settings

%load('s112_ses1_sfinal.mat')
cond = expinfo.condition;
N200_window = 100:300; %research window for N200 estimation
N200_subset = [16 10 4 5 12 19 18 11 6]; %subset of electrodes that are located in the N200 area


%% Plots of the parameters estimation by averaging across electrodes and trials (grouping by condition)

par_0 = [1500 200 20 1.5 1500 40]; %first estimation of the parameters

for i=1:6
    subplot(2,6,i);
    N200_m = N200_m_cond(data,cond,i,N200_window,N200_subset);

    par_opt = fminsearch(@(par) norm(F_obj(N200_m',N200_2(par,N200_window),par,N200_window)),par_0,optimset('Display','off'));
    model = N200_2(par_opt,N200_window);
    plot(N200_window,N200_m);
    hold on
    plot(N200_window,model); 
end    



%% N200 estimations for each trial by averaging across electrodes (grouping by conditions)

for i=1:6
    study = condition_selection(data,cond,i); %selection of condition
    
    N200_est = zeros(size(study,3),1); %stocks the latencies of the N200s

    for j=1:size(study,3)

        sample = mean(study(N200_window,N200_subset,j),2); %selection of the sample
        par_opt = fminsearch(@(par) norm(F_obj(sample',N200_2(par,N200_window),par,N200_window)),par_0,optimset('Display','off')); %Nelder-Mead simplex
        N200_est(j) = par_opt(2); %estimation of the amplitude and the N200

    end
    N200_est = N200_est(N200_est<260,:); %filter excessive outliers (arbitrary values)
    N200_est = N200_est(N200_est>140,:); 
    
    subplot(2,6,6+i);
    histfit(N200_est,10,'kernel'); %histogram and density estimation
    
end


