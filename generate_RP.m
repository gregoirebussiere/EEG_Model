%% Generate Stereotyped Readiness Potential waveform
% The RP has three parameters:
%  - par(1): an amplitude parameter, expressed in microvolts
%  - par(2): a location parameter, the timing of the negative peak, expressed in milliseconds
%  - par(3): a scale parameter, the time from negative peak to full recovery, expressed in milliseconds

function [RP] = generate_RP(par,x)
% par(2)+par(3) = time of full recovery
% The functional form of the RP stereotype is an inverted log-normal function
RP = - par(1)*(x < par(2)+par(3)) .* exp(-0.5 * log(((par(2)+par(3))-x) / par(3)).^2);
