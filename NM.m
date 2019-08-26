%% Nelder-Mead Simplex to estimate the EEG parameters

function [par_opt,R] = NM(par0,dir,x,y,alpha,ind)
    % par0: first approximation of the parameters
    % x: time
    % y: EEG
    % alpha: NM algorithm parameter that influence the reflection

    n = length(par0);

    %Parameters
    gamma = 1;
    rho = 0.5;
    sigma = 0.5;

    %Initialisation simplex
    X = zeros(n+1,n);

    x1 = par0;
    X(1,:) = x1;


    for i=1:length(x1)
        xi = x1;
        xi(i) = xi(i) + dir(i);
        X(i+1,:) = xi; 
    end

    F = zeros(n+1,1);

    for i=1:n+1
        F(i) = Oracle(X(i,:),x,y,ind);
    end

    [F,ord] = sort(F);

    R = [];
    while abs(F(1)-F(n+1)) > 0.01 %Termination criteria

        X = X(ord,:);

        x0 = mean(X(1:n,:)); %centroid
        xr = x0 + alpha * (x0 - X(n+1,:)); %reflection
        F_xr = Oracle(xr,x,y,ind);

        if F(1) <= F_xr < F(n+1) %First case
            X(n+1,:) = xr;
            F(n+1) = F_xr;

        elseif F_xr < F(1) %Second case
            xe = x0 + gamma*(xr - x0); %Expansion
            F_xe = Oracle(xe,x,y,ind);

            if F_xe < F_xr
                X(n+1,:) = xe;
                F(n+1) = F_xe;
            else
                X(n+1,:) = xr;
                F(n+1) = F_xr;
            end

        else
            xc = x0 + rho*(X(n+1,:)-x0); %Contraction
            F_xc = Oracle(xc,x,y,ind);
            if F_xc < F(n+1)
                X(n+1,:) = xc;
                F(n+1) = F_xc;
            else
                for i=2:n+1 %Shrinking
                    X(i,:) = X(1,:) + sigma * (X(i,:)-X(1,:));
                    F(i) = Oracle(X(i,:),x,y,ind);
                end
            end

        end

        [F,ord] = sort(F);
        R = [R F(1)];

    end
    par_opt = X(1,:);
end