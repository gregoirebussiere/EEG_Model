%% Estimation of the N200 parameters with the Nelder-Mead simplex and acceptation of the solutions
eeg = load('s112_ses1_sfinal.mat');

window = eeg.stimlocked.window;%Time window
par_0 = [70000 200 50 0 70000 50];%Initialization of the parameters

pars = [];
accept  = zeros(1,480);

for i=1:6
    study = condition_selection(eeg.stimlocked.sterp,eeg.expinfo.condition,i);%condition selection 
    par_temp = [];
    
    for j=1:80

        sample = study(:,j); %selection of the sample
        par_opt = fminsearch(@(par) norm(F_pen(sample',N200_2(par,window),par,window)),par_0,optimset('Display','off')); %Nelder-Mead simplex
        if accept_par(par_opt)
            par_temp = [par_temp;par_opt];
            accept((i-1)*80 + j) = 1;
        end
    
    end

    pars = [pars;par_temp];
    
end

% histfit(pars(:,2))
%pd =fitdist(pars(:,2),'Normal');
