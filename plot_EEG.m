function plot_EEG(par,x)
N200 = generate_N200(par(1:3),x);
P300 = generate_P300(par(4:6),x);
RP = generate_RP(par(7:9),x);
plot(x,N200 + P300 + RP);
end