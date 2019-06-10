%% Calculate the jacobian of the objective function F = EEG - model
function [J] = jacobian(par,x)

J = zeros(length(x),length(par));

%Frequently used terms
expN200 = exp(-0.5*((x-par(2))/par(3)).^2);
expP300 = exp(-0.5*((x-par(5))/par(6)).^2);
expRP = exp(-0.5*log(-(x-par(8)-par(9))/par(9)).^2);

%N200 terms
J(:,1) = -(x-par(2))/par(3) .* expN200;
J(:,2) = -par(1) .* ((x-par(2)).^2/par(3)^3 - 1/par(3)) .* expN200;
J(:,3) = -par(1) .* (x-par(2))/par(3)^2 .* (((x-par(2))/par(3)).^2 - 1) .*expN200;

    

%P300 terms
J(:,4) =  expP300;
J(:,5) =  par(4) .* (x-par(5))/par(6)^2 .* expP300;
J(:,6) =  par(4) .* (x-par(5)).^2/par(6)^3 .* expP300;



%RP terms
J(:,7) =  (x < par(8)+par(9)) .* expRP;
J(:,8) =  par(7) .* (x < par(8)+par(9)) .* log(-(x-par(8)-par(9))/par(9))./(x-par(8)-par(9)) .* expRP;
J(x==par(8)+par(9),8) = 0;
J(:,9) =  par(7) .* (x < par(8)+par(9)) .* (x-par(8))./(par(9)*(x-par(8)-par(9))) .* log(-(x-par(8)-par(9))/par(9)) .* expRP;
J(x==par(8)+par(9),9) = 0;




end