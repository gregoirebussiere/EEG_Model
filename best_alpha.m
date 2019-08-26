%% Calculate the best alpha for the Nelder-Mead algorithm

function [S] = best_alpha(par0,dir,se,x,n)
    % par0 first iteration
    % se: standard error for the EEG generation
    % x array of EEG evaluation
    % n number of tested values

    alpha = linspace(0.8,0.999,n); % array of tested values
    N = zeros(1,n);

    S = zeros(1,100);
    for i=1:100
        i
        [EEG,par] = random_EEG(par0,se,x); %Random EEG
        for j=1:length(alpha)
            j
            N(j) = norm(par-NM(par0,dir,x,EEG,alpha(j),3)'); % norm of the difference with the real parameters
        end
        figure()
        plot(alpha,N)
        text(0.78, 30, 'F(\theta_{opt})', 'HorizontalAlignment', 'center', 'Rotation', 90)
        text(0.895, -6, 'alpha')
        
        [m,ind] = min(N);
        best_alpha = alpha(ind); % value that will be used for the future executions of the NM algorithm
        S(i) = best_alpha;

    end
    mean(S) %Mean
end