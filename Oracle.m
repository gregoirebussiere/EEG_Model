%% Calculation of residuals and jacobian
function [F,J] = Oracle(par,x,y)
N200 = generate_N200(par(1:3),x);
P300 = generate_P300(par(4:6),x);
RP = generate_RP(par(7:9),x);
F = F_obj(y,weighted_sum(par(10:12),N200,P300,RP));
J = jacobian(par,x);
