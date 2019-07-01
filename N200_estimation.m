function [N200,amp] = N200_estimation(model,N200_window)
    [amp,N200] = min(model);
    N200 = N200 + N200_window(1) - 1;
end