function [opt_p] = cvxWaterfilling(N, B, N0, h, Pmax)
%CVXWATERFILLING This function allows to solve the waterfilling problem 
%employing CVX
%   Input arguments:
%   N => Number of subcarriers
%   B => Total Bandwidth
%   N0 => Noise Power Spectral Density
%   h => Channel gain vector
%   Pmax => Power budget
%   Output arguments
%   opt_p => Optimal Power Allocation
Bc = B/N;
cvx_begin quiet
    variable p(N)
    maximize(Bc*sum_log(1+(p.*h.^2)/(Bc*N0)))
    subject to 
    sum(p)<=Pmax
    p>=0
cvx_end
opt_p = p;
end

