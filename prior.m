function [pr] = prior(par,mu_prior,sigma_prior)
    pr = zeros(1,6);
    pr(1) = normpdf(par(1),mu_prior(1),sigma_prior(1));
    pr(2) = normpdf(par(2),mu_prior(2),sigma_prior(2));
    pr(3) = normpdf(par(3),mu_prior(3),sigma_prior(3));
    pr(4) = normpdf(par(4),mu_prior(4),sigma_prior(4));
    pr(5) = normpdf(par(5),mu_prior(5),sigma_prior(5));
    pr(6) = normpdf(par(6),mu_prior(6),sigma_prior(6));
end