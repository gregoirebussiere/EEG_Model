%% Test of acceptation of the solution
function [ok] = accept_par(par_opt)
    ok = 1;
    if (par_opt(1) > 500000 || par_opt(5) > 500000 )%Too large
        ok = 0;
    elseif (par_opt(1) < 1000 || par_opt(5) < 1000 )%Too small
        ok = 0;
    elseif (par_opt(2) > 275 || par_opt(2) < 125 )%Out of the window
        ok = 0;
    end
end