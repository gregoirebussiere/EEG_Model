function [data_cond] = condition_selection(data,cond,ind)
    data_cond = data(:,cond == ind);
end