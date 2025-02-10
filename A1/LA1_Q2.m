%%%%%%%%% Lab Assignment 1  %%%%%%%%%
%   Shreyansh Sharma (SR - 22631)   %
%       M.Tech RAS 1st Year         %

% QUESTION 2%
close all;
clear all;
clc;

%givens
alpha = 5e-2;   %diffusion constants
alpha_h = 3.6e-3;
alpha_e = 8e-3; 
Te = 15;
Th = 100;       %temperature of heater
tspan = [0 50];

%initial temperatures of the rooms
T0 = [10; 15; 20; 25; 30];  

%Function handle for the differential equations
f = @(t, Temp)([alpha*(Temp(2)-Temp(1)) + alpha_e*(Te-Temp(1)) ; alpha*(Temp(1) - Temp(2)) + alpha*(Temp(3) - Temp(2)) + alpha*(Temp(4) - Temp(2)) + alpha*(Temp(5) - Temp(2)) + alpha_h*(Th - Temp(2)) ; alpha*(Temp(2) - Temp(3)) + alpha_e*(Te - Temp(3)) ; alpha*(Temp(2) - Temp(4)) + alpha*(Te - Temp(4)) ; alpha*(Temp(2) - Temp(5)) + alpha_e*(Te - Temp(5))]);

%solving the differential equations to get temperatures over time. 
[t temperatures] = ode45(f, tspan, T0);

%plotting the obtained temperatures
fig2 = figure();
hold on
plot(t, temperatures(:,1), '-r', 'LineWidth', 1);
plot(t, temperatures(:,2), '-b', 'LineWidth', 1);
plot(t, temperatures(:,3), '-g', 'LineWidth', 1);
plot(t, temperatures(:,4), '-c', 'LineWidth', 1);
plot(t, temperatures(:,5), '-m', 'LineWidth', 1);
hold off
set(gca, 'FontName', 'SansSerif', 'FontSize', 9)
title("Q2. Evolution of temperatures of rooms")
xlabel('Time (in seconds)');
ylabel('Temperature (in deg. celcius)');
legend('Room 1', 'Room 2', 'Room 3', 'Room 4', 'Room 5');
grid on;
