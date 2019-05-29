%% Gauss_Newton algorithm with Wolfe linear research
function [par0] = gauss_newton(par0,x,y)
[F,J] = Oracle(par0,x,y);
crit = -J'*F; %gradient
while norm(crit)>1
    delta = J\F;
    %alpha = wolfe(par0,x,y,delta);
    par0 = par0 + delta;
    [F,J] = Oracle(par0,x,y);
    crit = -J'*F;
end

end