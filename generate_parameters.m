%% Generate random parameters from a Gaussian distribution
% 3 parameters per ERP component (3) and 3 weights = 12
function [par]=generate_parameters(means,se)
par = zeros(length(means),1);
for i = 1:length(par)
    par(i) = normrnd(means(i),se(i));
end
end
