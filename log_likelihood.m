function [log_L] = log_likelihood(R,sigma)
    n = length(R);
    log_L = -0.5 * ( n*log(2*pi) + sum(log(sigma.^2)) + sum((R./sigma).^2) );
end