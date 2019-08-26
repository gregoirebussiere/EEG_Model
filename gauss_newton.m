%% Gauss_Newton algorithm with Wolfe linear research
function [par0] = gauss_newton(par0,x,y)
[F,J] = Oracle(par0,x,y,1);
for i=1:1000
    delta = J\F;
    alpha = wolfe(par0,x,y,delta);
    par0 = par0 + alpha * delta';
    [F,J] = Oracle(par0,x,y,1);
end

end