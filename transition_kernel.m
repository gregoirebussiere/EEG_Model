%% Metropolis algorithm kernel
function [trans] = transition_kernel(theta,sigma)

    trans = zeros(1,length(theta));
    
    for i=1:length(theta)
        trans(i) = normrnd(theta(i),sigma(i));
    end
    
end