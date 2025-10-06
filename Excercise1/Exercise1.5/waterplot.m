function [] = waterplot(power_allocation,noise_power)
%waterplot This function plots the waterplot from the optimal power
%allocation and the noise power vector
%   Input arguments:
%   power_allocation => Optimal power allocation
%   noise_power => \gamma_i = (Bc*N0)/(h.^2)

axis_vals = 1:1:numel(power_allocation);

figure;
hold on;
bar(axis_vals, [noise_power,power_allocation],'stacked', 'FaceAlpha', 0.4, ...
    'DisplayName', 'p_i');
[~, index] = max(power_allocation);
waterlevel = (power_allocation + noise_power);

% Plot the horizontal line for the optimal water level (\nu^*)
waterlevel = waterlevel(index);
yline(waterlevel, 'LineStyle', '--', 'LineWidth', 2,'Color', 'green');

% Customize the x-axis
xticks(axis_vals);
xlabel('Subcarrier Number', 'FontSize', 14);

% Set the y-axis label
ylabel('Allocated Power [W]', 'FontSize', 14);

% Add the legend
legend('FontSize', 11);

% Enable the grid
grid on;

% Show the plot
hold off;
l = legend('$\frac{1}{\gamma_i}$', '$p_i$','$\nu^{*}$');
set(l,'interpreter','latex');
set(l,'FontSize',14);

end

