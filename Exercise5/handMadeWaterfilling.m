function [opt_p, level] = handMadeWaterfilling(N, B, N0, h, Pmax)
%CVXWATERFILLING This function allows to solve the waterfilling problem by
%using the iterative algorithm

%   Input arguments:
%   N => Number of subcarriers
%   B => Total Bandwidth
%   N0 => Noise Power Spectral Density
%   h => Channel gain vector
%   Pmax => Power budget
%   Output arguments
%   opt_p => Optimal Power Allocation

    % Bandwidth per sub-channel
    Bc = B / N;  
    % Power of the noise per sub-channel (inverse SNR)
    p_noise = (Bc * N0) ./ (h.^2);  
    % Sorting the noise powers
    sorted_noise = sort(p_noise);  
    % Initialize the optimal power allocation
    opt_p = zeros(1, N);  

    % Remaining power to be allocated
    p_res = Pmax;  
    % Start water level with the smallest noise power
    level = sorted_noise(1);  

    % Loop through the sorted noise values to perform water-filling
    for i = 1:length(sorted_noise)
        % Last iteration check
        if i == length(sorted_noise)  
            if p_res > 0
                padj = p_res / N;  
                level = level + padj;
                ploss = p_res;  
            end
        else
            residual = sorted_noise(i + 1) - level;  
            if p_res - residual * i < 0 
                padj = p_res / i;  
                level = level + padj;
                ploss = p_res;  
            else
                padj = residual;  
                level = level + residual;
                ploss = padj * i; 
            end
        end
        opt_p(1:i) = opt_p(1:i) + padj;  % Update power allocation for the first i channels
        p_res = max(0, p_res - ploss);  % Update remaining power
    end
    
    opt_p = max(0, level - p_noise);  % Ensure non-negative power allocation

end

