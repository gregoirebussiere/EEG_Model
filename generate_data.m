%% Generates n random EEGs
function [data,par] = generate_data (n,means,se,x)
    %n: number of generated EEGs
    %means: mean of the gaussian distribution
    %se: standard-error of the gaussian distribution
    %x: time
    data = zeros(n,length(x));
    par = zeros(n,length(means));
    for i=1:n
        [data(i,:),par(i,:)] = random_EEG(means,se,x);
    end
end