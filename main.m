%% Main script to generate data  

%Reproductible code
rng(0)

%Objective values
means = [ 3 200 80 1 300 50 0.8 750 100 1 1 1]';
%Standard errors
se = [0.3 16 8 0.1 30 5 0.08 75 10 0.1 0.1 0.1];

x = linspace(-500, 1500, 4001);

%Objective EEG
N200_obj = generate_N200(means(1:3),x);
P300_obj = generate_P300(means(4:6),x);
RP_obj = generate_RP(means(7:9),x);
EEG_obj = weighted_sum(means(10:12),N200_obj,P300_obj,RP_obj);


%Generate an EEG close to the objective one with white noise on parameters

par = generate_parameters(means,se);
N200 = generate_N200(par(1:3),x);
P300 = generate_P300(par(4:6),x);
RP = generate_RP(par(7:9),x);
gau_noise = 1/15 * randn(size(x));
EEG = weighted_sum(par(10:12),N200,P300,RP);



%plot of the objective and the generated EEGs
plot(x,EEG_obj)
hold on 
plot(x,EEG)

f = F_obj(EEG_obj,EEG);
norm(f)