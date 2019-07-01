%% Second derivative of Gaussian
function [N200] = N200_2(par,x)
    N200 = zeros(1,length(x));
    for i=1:length(x)
        if x(i)<par(2)
            N200(i) = par(1) .* exp(-0.5 * ((x(i)-par(2))/par(3)).^2) .* (((x(i)-par(2))/par(3)^2).^2 - 1/par(3)^2) + par(4) ;
        else
            N200(i) = par(5) .* exp(-0.5 * ((x(i)-par(2))/par(6)).^2) .* (((x(i)-par(2))/par(6)^2).^2 - 1/par(6)^2) + par(4) - par(1)/par(3)^2 + par(5)/par(6)^2;
        end
    end
end