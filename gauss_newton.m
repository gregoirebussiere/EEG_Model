function [par0] = gauss_newton(par0,x,y)
[F,G] = Oracle(par0,x,y);
crit = G'*F
while norm(crit)>0.1
    delta = -G\F;
    %alpha = wolfe(par0,x,y,delta);
    par0 = par0 +  delta
    [F,G] = Oracle(par0,x,y);
    crit = G'*F
end

end