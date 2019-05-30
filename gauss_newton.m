%% Gauss_Newton algorithm with Wolfe linear research
function [par0] = gauss_newton(par0,x,y)
[F,J] = Oracle(par0,x,y);
crit = J'*F; %gradient
for i=1:10
    delta = -J\F;
    alpha = wolfe(par0,x,y,delta);
    par0 = par0 + alpha * delta
    [F,J] = Oracle(par0,x,y);
    crit = J'*F;
end

end