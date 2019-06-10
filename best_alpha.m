%% Calculate the best alpha for the Nelder-Mead algorithm

function [S] = best_alpha(par0,se,x,n)
    % par0 first iteration
    % se: standard error for the EEG generation
    % x array of EEG evaluation
    % n number of tested values

    alpha = linspace(0.1,2,n); % array of tested values
    N = zeros(1,n);

    S = 0;
    for i=1:100
        i
        [EEG,par] = random_EEG(par0,se,x); %Random EEG
        for j=1:length(alpha)
            N(j) = norm(par-NM(par0,x,EEG,alpha(j))'); % norm of the difference with the real parameters
        end

        [m,ind] = min(N);
        best_alpha = alpha(ind); % value that will be used for the future executions of the NM algorithm
        S = S + best_alpha;

    end
    S = S/100; %Mean
end