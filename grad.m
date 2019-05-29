%% Calculate the gradient of the objective function F = EEG - model
function [G] = grad(par,x)

G = zeros(length(x),length(par));
%Frequently used terms
expN200 = exp(-0.5*((x-par(2))/par(3)).^2);
expP300 = exp(-0.5*((x-par(5))/par(6)).^2);
expRP = exp(-0.5*log(-(x-par(8)-par(9))/par(9)).^2);

%N200 terms
G(:,1) = -par(10) .* (x-par(2))/par(3) .* expN200;
G(:,2) = -par(1) .* par(10) .* ((x-par(2)).^2/par(3)^3 - 1/par(3)) .* expN200;
G(:,3) = -par(1) .* par(10) .* (x-par(2))/par(3)^2 .* (((x-par(2))/par(3)).^2 - 1) .*expN200;
G(:,10) = -par(1) .*  (x-par(2))/par(3) .* expN200;
    

%P300 terms
G(:,4) = par(11) .* expP300;
G(:,5) = par(4) .* par(11) .* (x-par(5))/par(6)^2 .* expP300;
G(:,6) = par(4) .* par(11) .* (x-par(5)).^2/par(6)^3 .* expP300;
G(:,11) = par(4) .* expP300;


%RP terms
G(:,7) = par(12) .* (x < par(8)+par(9)) .* expRP;
G(:,8) = par(7) .* par(12) .* (x < par(8)+par(9)) .* log(-(x-par(8)-par(9))/par(9))./(x-par(8)-par(9)) .* expRP;
G(:,9) = par(7) .* par(12) .* (x < par(8)+par(9)) .* (x-par(8))./(par(9)*(x-par(8)-par(9))) .* log(-(x-par(8)-par(9))/par(9)) .* expRP;
G(:,12) = par(7) .* (x < par(8)+par(9)) .* expRP;


end