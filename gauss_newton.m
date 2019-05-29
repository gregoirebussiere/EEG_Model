%% Gauss_Newton algorithm with Wolfe linear research
function [par0] = gauss_newton(par0,x,y)
[F,G] = Oracle(par0,x,y);
crit = G'*F; %gradient
while norm(crit)>0.1
    delta = -G\F;
    alpha = wolfe(par0,x,y,delta);
    par0 = par0 + alpha * delta;
    [F,G] = Oracle(par0,x,y);
    crit = G'*F;
end

end