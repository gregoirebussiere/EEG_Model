%% Generate Stereotyped P300 waveform
% The P300 has three parameters:
%  - par(1): an amplitude parameter, expressed in microvolts
%  - par(2): a location parameter, expressed in milliseconds
%  - par(3): a scale parameter, expressed in milliseconds

function [P300] = generate_P300(par,x)
% The functional form of the P300 stereotype is a scaled Gaussian function
P300 = par(1)*exp(-0.5 .* ((x-par(2)) ./ par(3)) .^ 2);
end