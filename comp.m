%% Comparison of handmade Nelder-Mead simplex and built-in one

sterp_ordered = [eeg.stimlocked.sterp(:,241:480) eeg.stimlocked.sterp(:,1:240)]; %ordering
g = sterp_ordered(:,accept==1); %selection of correct trials

P1 = zeros(length(g(1,:)),6);% parameters with built-in function
P2 = zeros(length(g(1,:)),6);% parameters with handmade function
F1 = zeros(length(g(1,:)),1);% values of F with built-in function
F2 = zeros(length(g(1,:)),1);% values of F with handmade function


for i=1:length(g(i,:))
    P1(i,:) = fminsearch(@(par) norm(F_pen(g(:,i)',N200_2(par,window),par,window)),par_0,optimset('Display','off'));
    F1(i) = norm(F_pen(g(:,i)',N200_2(P1(i,:),window),P1(i,:),window));
    P2(i,:),r = NM(par_0,dir,window,g(:,i)',best_alpha,2);
    F2(i) = norm(F_pen(g(:,i)',N200_2(P2(i,:),window),P2(i,:),window));
end

% plot(window,g(:,1))
% hold on
% plot(window,N200_2(P1(1,:),window))
% plot(window,N200_2(P2(1,:),window))


figure
plot(F1-F2);
xlabel('Trial')
ylabel('F1-F2')
title('Comparison of the two methods')