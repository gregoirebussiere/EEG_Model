function [J] = jacobian3(par,x)
    J = zeros(length(x),length(par));
    expN200 = exp(-0.5*((x-par(2))/par(3)).^2);
    J(:,1) = - expN200 .* ( ( (x - par(2)) / par(3)^2 ) .^2 - 1/par(3)^2);
    J(:,2) = - par(1) * expN200 .* 1/par(3)^6 .* (x.^3 - 3*x.^2*par(2) + 3*x*par(2)^2 - 3*x*par(3)^2 + 3*par(2)*par(3)^2 - par(2)^3);
    J(:,3) = - par(1) * expN200 .* 1/par(3)^7 .* (x.^4 -4*x.^3*par(2) + 6*x.^2*par(2)^2 - 5*x.^2*par(3)^2 + 10*x*par(2)*par(3)^2 - 4*x*par(2)^3 + 2*par(3)^4 + par(2)^4 - 5*par(2)^2*par(3)^3);
    J(:,4) = - 1;
end