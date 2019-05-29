%% Sum the 3 ERP components according to their weights
function [weighted_sum] = weighted_sum(par,N200,P300,RP)
weighted_sum = par(1) * N200 + par(2) * P300 + par(3) * RP;
