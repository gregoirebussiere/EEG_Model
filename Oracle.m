%% Calculation of residuals and jacobian
function [F,J] = Oracle(par,x,y,ind)

if ind==1
    N200 = generate_N200(par(1,1:3),x);
    P300 = generate_P300(par(1,4:6),x);
    RP = generate_RP(par(1,7:9),x);
    F = F_obj(y,N200+P300+RP);
    J = jacobian(par,x);

elseif ind==2
    N200 = generate_N200(par(1,1:3),x);
    P300 = generate_P300(par(1,4:6),x);
    RP = generate_RP(par(1,7:9),x);
    F = F_obj(y,N200+P300+RP);
    
elseif ind==3
    N200 = generate_N200(par(1,1:3),x);
    P300 = generate_P300(par(1,4:6),x);
    RP = generate_RP(par(1,7:9),x);
    F = norm(F_obj(y,N200+P300+RP));
    
end