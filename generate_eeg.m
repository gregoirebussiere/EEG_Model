%% GENERATE_EEG  Generates and plots data from the VNS ERP measurement model
% This function generates predictions and sample data from the ERP
% measurement model developed by Vandekerckhove, Nunez, and Srinivasan.
% The current implementation uses three 'stereotyped' ERP functions (N200,
% P300, and RP) and Gaussian noise.  It generates a single chain of
% simulated data (i.e., for one channel/electrode and for trial within one
% condition and participant).
% This is just one of several possible ERP measurement models

% - 2018/06/06 v0.0.0 by joachim@ - original version
% - 2019/05/13 v0.0.1 by joachim@ - minor changes to waveform parameterization

%% Environment
% MATLAB Version: 9.2.0.556344 (R2017a)
% Operating System: Linux 4.15.0-48-generic #51-Ubuntu SMP Wed Apr 3
% 08:28:49 UTC 2019 x86_64
% Java Version: Java 1.7.0_60-b19 with Oracle Corporation Java HotSpot(TM)
% 64-Bit Server VM mixed mode

%% Preface
% Set the random seed for reproducibility.
rng(0)


%% Graphical parameters
% Open new figure and set axis limits
figure()

yMax =    2;
yMin =   -2;
xMin = -500;
xMax = 1500;
axis([xMin, xMax, yMin, yMax])

xax = linspace(xMin, xMax, 4001);  % x axis

% Colors for the three ERP functions (red, purple, green)
color = {[.8 .1 .1], [.6 .1 .6], [.1 .8 .1]};

% Slight vertical offset so the stereotyped functions don't overlap
offset = .1;

% Set default options for (l)ine plotting and (t)ext
lops = {'linewidth', 4, 'linestyle', '-'};
tops = {'fontweight', 'bold', 'HorizontalAlignment', 'center'};


%% Stereotyped P300 waveform
% The P300 has three parameters:
%  - P300_loc: a location parameter, expressed in milliseconds
%  - P300_sca: a scale parameter, expressed in milliseconds
%  - P300_amp: an amplitude parameter, expressed in microvolts

P300_loc = 300;
P300_sca =  50;
P300_amp =   1;

% The functional form of the P300 stereotype is a scaled Gaussian function
P300 = @(x) P300_amp .* exp(-0.5 .* ((x-P300_loc) ./ P300_sca) .^ 2);


%% Stereotyped Readiness Potential waveform
% The RP has three parameters:
%  - RP_neg: a location parameter, the timing of the negative peak, expressed in milliseconds
%  - RP_sca: a scale parameter, the time from negative peak to full recovery, expressed in milliseconds
%  - RP_amp: an amplitude parameter, expressed in microvolts

RP_neg =  750;
RP_sca =  100;
RP_amp =  0.8;

RP_rec =  RP_neg + RP_sca;  % time of full recovery

% The functional form of the RP stereotype is an inverted log-normal function
RP = @(x) -RP_amp .* (x < RP_rec) .* exp(-0.5 * log((RP_rec-x) / RP_sca).^2);


%% Stereotyped N200 waveform
% The N200 has three parameters:
%  - N200_neg: a location parameter, the timing of the negative peak, expressed in milliseconds
%  - N200_sca: a scale parameter, the time from positive to negative peak, expressed in milliseconds
%  - N200_amp: an amplitude parameter, expressed in microvolts

N200_neg = 200;
N200_sca =  80;
N200_amp =   3;

N200_hpd = N200_sca / 2;             % half period of the waveform
N200_zcr = N200_neg - N200_sca / 2;  % time of zero-crossing

% The functional form of the N200 stereotype is a first derivative of a
% Gaussian function
N200 = @(x) -N200_amp .* exp(-0.5 * ((x-N200_zcr)/N200_hpd).^2) .* ((x-N200_zcr)/N200_hpd);


%% Drawing the waveforms
% Draw P300
line(xax, P300(xax) + offset  , lops{:}, 'color', color{1})

% Draw Readiness Potential
line(xax, RP(xax)   - offset  , lops{:}, 'color', color{2})

% Draw N200
line(xax, N200(xax) - offset/2, lops{:}, 'color', color{3})

% Draw reference line
line([xMin xMax], [0, 0], 'linestyle', '--', 'color', 'k')


%% Adding annotations
% Mark observed N200 peak and 200ms point
%line([N200_neg N200_neg], -[2.1 1.9], 'color', 'k')
line([     200      200], -[2.1 1.9], 'color', 'k')
line([     300      300], -[2.1 1.9], 'color', 'k')
line([     750      750], -[2.1 1.9], 'color', 'k')

% Add bracket under N200 offset interval and label as \theta
%text( N200_neg + 18, -2.2, '\{', 'color', 'k', tops{:}, ...
%   'fontsize', 11, 'fontweight', 'normal', ...
%    'rotation', 90, 'HorizontalAlignment', 'center')
%text( N200_neg + 20, -2.35, '\theta', 'color', 'k', tops{:}, ...
%    'fontsize', 11, 'fontweight', 'normal', ...
%    'interpreter', 'tex', 'HorizontalAlignment', 'center')

% Mark and label the N200 peak and the 200ms point
text(200 , -2.2, '200', tops{:}, 'fontsize', 8)
text(300 , -2.2, '300', tops{:}, 'fontsize', 8)
text(750 , -2.2, '750', tops{:}, 'fontsize', 8)
%line([200 275], [-2 -2.34], 'linestyle', ':', 'color', 'k')
%text(N200_neg - 100, -2.45, '160', tops{:}, 'fontsize', 8)
%line([160 85], [-2 -2.34], 'linestyle', ':', 'color', 'k')

% Add labels to the waveforms
text( P300_loc + 150,  P300_amp * 1.0, 'P300', 'color', color{1}, tops{:})
text( N200_neg - 150, -N200_amp * 0.5, 'N200', 'color', color{3}, tops{:})
text( RP_neg   + 250, -RP_amp   * 1.2, sprintf('Readiness\nPotential'), 'color', color{2}, tops{:})

% Add axis labels
text(-700, -0, 'potential', 'HorizontalAlignment', 'center', 'Rotation', 90)
text(950, -1.8, 'time course (ms)')


%% Add the simulated data
% The model prediction is a weighted sum of the stereotyped ERPs
weights = [1 1 1];

model = ...
      weights(1) * P300(xax) ...
    + weights(2) * RP(xax) ...
    + weights(3) * N200(xax);


% Here we add some sinusoidal noise, but this should be turned off for
% model recovery studies!
sin_noise = ...
       + 0.1 * sin(xax/1000*pi) ...
       + 0.2 * sin(xax/500*pi) ...
       + 0.1 * sin(xax/100*pi) ...
       + 0.2 * sin(xax/50*pi) ...
       + 0.1 * sin(xax/10*pi) ...
       + 0.2 * sin(xax/5*pi);

% Finally, we add gaussian noise
gau_noise = 1/15 * randn(size(xax));

% Plot the sum of model and all noise sources
hold on
plot(xax, model + gau_noise , ...
    'Zdata', -ones(size(xax)),...
    'color', [.7 .7 .7], 'Clipping', 'off')


%%
% addpath ~/Dropbox/MATLAB/
% figure(1), savepic('~/Downloads/neurodatarr/pics/stereotypical1.eps')
% figure(2), savepic('~/Downloads/neurodatarr/pics/stereotypical2.eps')

%!cd /tmp/generalizability/ && git add * && git commit -am "matlab" && git push 