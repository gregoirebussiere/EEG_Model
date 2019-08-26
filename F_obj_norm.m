%% Norm of objective function (Obsolete)
function [F_norm] = F_obj_norm(sample,par,N200_window)
    F_o = F_obj(sample',N200_2(par,N200_window),par,N200_window);
    F_norm = norm(F_o(1:round(par(2))-N200_window(1)+1)) + norm(F_o(round(par(2))-N200_window(1)+2:length(F_o)));
end