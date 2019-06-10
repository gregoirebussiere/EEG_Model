%% Calculate the jacobian of the objective function F = EEG - model
function [J] = jacobian2(par,x)

J = zeros(length(x),length(par));
%Frequently used terms
expN200 = exp(-0.5*((x-par(1))/par(2)).^2);
expP300 = exp(-0.5*((x-par(3))/par(4)).^2);
expRP = exp(-0.5*log(-(x-par(5)-par(6))/par(6)).^2);

%N200 terms

J(:,1) = ((x-par(1)).^2/par(2)^3 - 1/par(2)) .* expN200;
J(:,2) = (x-par(1))/par(2)^2 .* (((x-par(1))/par(2)).^2 - 1) .*expN200;

    

%P300 terms

J(:,3) = -(x-par(3))/par(4)^2 .* expP300;
J(:,4) =  -(x-par(3)).^2/par(4)^3 .* expP300;



%RP terms

J(:,5) = -(x < par(5)+par(6)) .* log(-(x-par(5)-par(6))/par(6))./(x-par(5)-par(6)) .* expRP;
J(x==par(5)+par(6),5) = 0;
J(:,6) = -(x < par(5)+par(6)) .* (x-par(5))./(par(6)*(x-par(5)-par(6))) .* log(-(x-par(5)-par(6))/par(6)) .* expRP;
J(x==par(5)+par(6),6) = 0;


J=sparse(J);
end