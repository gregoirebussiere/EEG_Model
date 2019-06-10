%% Generate Stereotyped N200 waveform
% The N200 has three parameters:
%  - par(1): an amplitude parameter, expressed in microvolts
%  - par(2): a location parameter, the timing of the negative peak, expressed in milliseconds
%  - par(3): a scale parameter, the time from positive to negative peak, expressed in milliseconds

function [N200] = generate_N200(par,x)
N200_hpd = par(3) / 2;             % half period of the waveform
N200_zcr = (par(2)-par(3)) / 2;  % time of zero-crossing

% The functional form of the N200 stereotype is a first derivative of a
% Gaussian function
N200 = par(1)*exp(-0.5 * ((x-N200_zcr)/N200_hpd).^2) .* (-((x-N200_zcr)/N200_hpd));
end