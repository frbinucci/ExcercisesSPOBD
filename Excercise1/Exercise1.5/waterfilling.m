clear all;
close all;

% Setting up the seed for reproducibility
rng(46);  % MATLAB's random seed function


fprintf("Welcome to the Waterfilling solver!")
fprintf("\nChoose an operational mode")
fprintf("\n1 - cvx waterfilling");
fprintf("\n2 - handmade waterfilling");
fprintf("\n3 - matlab waterfilling");

mode_to_test = input("\nMake a choice...");

% Channel parameters
% N = Number of subcarriers
% B = Total bandwidth
% Bc = Bandwidth per sub-carrier
% N0 = Noise Power Spectral Density
% pl = Average path loss
% Pmax = Maximum tx power
N = 16;
B = 20e6;
Bc = B / N;
N0 = 3.98e-21;
pl = 10^(-10);
Pmax = 1;

% Channel generation
h = (1/sqrt(2))*abs(randn(N, 1) * (1 + 1i));  % Generate complex Gaussian h

h = sqrt(pl) * h';  % Apply path loss
h = h(:);

%Power noise
pn = (Bc*N0)./h.^2;

% Decision based on mode_to_test
switch mode_to_test
    case 1
        [power_allocation] = cvxWaterfilling(N, B, N0, h, Pmax);
    case 2
        [power_allocation, level] = handMadeWaterfilling(N, B, N0, h, Pmax);
    case 3
        %The power noise vector is assumed to be a row vector!
        power_allocation = waterfill(Pmax,pn');
end

%Reshaping the vectors for plotting purposes...
power_allocation = reshape(power_allocation,N,1);
pn = reshape(pn,N,1);

if mode_to_test ==1 || mode_to_test==2 || mode_to_test==3
    waterplot(power_allocation,pn);
end
