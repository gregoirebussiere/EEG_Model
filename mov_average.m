function [F]=mov_average(x)
F = zeros(length(x));
for i = 1:length(x)
    F(i) = mean(x(max([1 i-5]):i));
end
end