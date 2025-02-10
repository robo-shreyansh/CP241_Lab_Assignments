%%%%%%%%% Lab Assignment 1  %%%%%%%%%
%   Shreyansh Sharma (SR - 22631)   %
%       M.Tech RAS 1st Year         %

% QUESTION 1%
close all;
clear all;
clc;

a=0.8;              % parameters a,b,c,d
b=0.5;
c=0.5;
d=0.2;
tspan= [0 50];      % time span (seconds)
x0 = [0.1 ; 0.5] ;  % initial conditions

%function handle for the state equations
f = @(t,x)([a*x(1) - b*x(1)*x(2) ; c*x(1)*x(2) - d*x(2)]);

% For solving through ODE45
[t_ode45, x_states_ode45] = ode45(f, tspan, x0);

% For solving through RK4 %
h = 0.001;          % considered time step
%%% The function LA1_RK4.m has been customly written
[t_rk4 x_states_rk4] = LA1_RK4(f, tspan, h, x0);
 
% __Part 1: Plot x1, and x2 with respect to time on the same plot:
fig1 = figure();
sgtitle('Q1 Part 1: x1, x2 vs. time')
subplot(2,1,1);
hold on
plot(t_ode45, x_states_ode45(:,1), '-r', 'LineWidth', 1);
plot(t_ode45, x_states_ode45(:,2), '-b', 'LineWidth', 1);
hold off
set(gca, 'FontName', 'SansSerif', 'FontSize', 9)
title('Solved by ODE45')
xlabel('Time (in seconds)')
ylabel('States')
legend('x1', 'x2')
grid on;

subplot(2,1,2);
hold on
plot(t_rk4, x_states_rk4(1,:), '-r', 'LineWidth', 1);
plot(t_rk4, x_states_rk4(2,:), '-b', 'LineWidth', 1);
hold off
set(gca, 'FontName', 'SansSerif', 'FontSize', 9)
title('Solved by RK4')
xlabel('Time (in seconds)')
ylabel('States')
legend('x1', 'x2')
grid on;
%%%%%%%%%%%%%% End of Part 1

% __Part 2: Plot x1 and x2 on the same graph:
fig2 = figure();
sgtitle('Q1 Part 2: x1 vs. x2')
subplot(2,1,1);
hold on
plot(x_states_ode45(:,1), x_states_ode45(:,2), '-m', 'LineWidth', 1);
hold off
set(gca, 'FontName', 'SansSerif', 'FontSize', 9)
title('Solved by ODE45')
xlabel('State x1')
ylabel('State x2')
grid on;

subplot(2,1,2);
hold on
plot(x_states_rk4(1,:), x_states_rk4(2,:), '-g', 'LineWidth', 1);
hold off
set(gca, 'FontName', 'SansSerif', 'FontSize', 9)
title('Solved by RK4')
xlabel('State (x1)')
ylabel('State (x2)')
grid on;
%%%%%%%%%%%%%% End of Part 2

% __Part 3: Find the equilibrium points & what will be the behaviour of system if initial conditons = eqb points
% Given system: 
%   x1_dot = a*x_1 - b*x_1*x_2
%   x2_dot = c*x_1*x_2 - d*x_2
% At equilbrium points, state dynamics are 0. That is x1_dot=0 & x2_dot=0
% Solving x1_dot=0, and x2_dot=0. We get two equilibrum points: (0,0), and (d/c, a/b)
% EQUILIBRIUM POINTS: (0,0), and (0.4, 1.6) (After putting values)
% We will plot the states for both these initial conditions

x0_initial_condition_1 = [0 ; 0];     % initial condition = eqb point1 = (0, 0)
x0_initial_condition_2 = [0.4 ; 1.6]; % initial condition = eqb point2 = (0.4, 1.6)

[t_initial_condition_1, x_states_initial_condition_1] = ode45(f, tspan, x0_initial_condition_1);
[t_initial_condition_2, x_states_initial_condition_2] = ode45(f, tspan, x0_initial_condition_2);

fig3 = figure();
sgtitle('Q1 Part 3: State evolution from equilibrium point')
subplot(2,2,1);
hold on
plot(t_initial_condition_1, x_states_initial_condition_1(:,1), '-r', 'LineWidth', 1);
plot(t_initial_condition_1, x_states_initial_condition_1(:,2), '-b', 'LineWidth', 1);
hold off
set(gca, 'FontName', 'SansSerif', 'FontSize', 9)
title('Initial Point: (0,0)');
xlabel('Time (in seconds)');
ylabel('States');
legend('x1', 'x2');
grid on;

subplot(2,2,2);
hold on
plot(t_initial_condition_2, x_states_initial_condition_2(:,1), '-r', 'LineWidth', 1);
plot(t_initial_condition_2, x_states_initial_condition_2(:,2), '-b', 'LineWidth', 1);
hold off
set(gca, 'FontName', 'SansSerif', 'FontSize', 9)
title('Initial Point: (0.4,1.6)');
xlabel('Time (in seconds)');
ylabel('States');
legend('x1', 'x2');
grid on;

subplot(2,2,3);
hold on
plot(x_states_initial_condition_1(:,1), x_states_initial_condition_1(:,2), '.r', 'LineWidth', 6);
hold off
set(gca, 'FontName', 'SansSerif', 'FontSize', 9)
xlabel('State x1')
ylabel('State x2')
grid on;

subplot(2,2,4);
hold on
plot(x_states_initial_condition_2(:,1), x_states_initial_condition_2(:,2), '.r', 'LineWidth', 6);
hold off
set(gca, 'FontName', 'SansSerif', 'FontSize', 9)
xlabel('State x1')
ylabel('State x2')
grid on;

fprintf("Q1 Part 3:\nThe equilibrium points are: (0,0) and (0.4, 1.6). \nIf initial conditions are set to equilibrium points, then state dynamics are zero initially, and therefore the states do not change over time, as seen in the obtained plots.\n(Provided there are no perturbations) \n\n\n");
% If initial conditions are set to equilibrium points, then the state
% state dynamics at initial moment are zero, and therefore 
% the states will NOT change.

%In short, if initial condition = eqb. points, then states do not change.
% (PROVIDED THERE IS NO PERTURBATION)

%%%%%%%%%%%%%% End of Part 3

% __Part 4: What if a or b or c or d are negative, plot and comment.__
% The given equations (Lotka Volterra model) represents predator prey
% dynamics.
%%% The state variable x1: prey population density
%%% The state variable x2: predator population density
% Lotka Volterra model requires the constants a,b,c,d to be non-negative

% So lets take 4 cases:
%%% Case 1: a negative, rest all positive
%%% Case 2: b negative, rest all positive
%%% Case 3: c negative, rest all positive
%%% Case 4: d negative, rest all positive

%%%%% Part 4, Case 1: a negative, rest all positive
a=-0.8; 
b=0.5; 
c=0.5; 
d=0.2;
x0 = [0.1; 0.5];    %initial conditions given
h=0.001;

f = @(t,x)([a*x(1) - b*x(1)*x(2) ; c*x(1)*x(2) - d*x(2)]);
[t_case1 x_states_case1] = LA1_RK4(f, tspan, h, x0);

fig4 = figure();
sgtitle('Q1 Part 4: System with one negative parameter');
subplot(2,2,1);
hold on
plot(t_case1, x_states_case1(1,:), '-r', 'LineWidth', 1);
plot(t_case1, x_states_case1(2,:), '-b', 'LineWidth', 1);
hold off
grid on;
title('a: negative')
xlabel('Time (in seconds)');
ylabel('Population density');
legend('Prey', 'Predator');

%%%%% Part 4, Case 2: b negative, rest all positive
a=0.8; 
b=-0.5; 
c=0.5; 
d=0.2;

f = @(t,x)([a*x(1) - b*x(1)*x(2) ; c*x(1)*x(2) - d*x(2)]);
[t_case2 x_states_case2] = LA1_RK4(f, tspan, h, x0);

subplot(2,2,2);
hold on
plot(t_case2, x_states_case2(1,:), '-r', 'LineWidth', 1);
plot(t_case2, x_states_case2(2,:), '-b', 'LineWidth', 1);
hold off
grid on;
title('b: negative')
xlabel('Time (in seconds)');
ylabel('Population density');
legend('Prey', 'Predator');

%%%%% Part 4, Case 3: c negative, rest all positive
a=0.8; 
b=0.5; 
c=-0.5; 
d=0.2;

f = @(t,x)([a*x(1) - b*x(1)*x(2) ; c*x(1)*x(2) - d*x(2)]);
[t_case3 x_states_case3] = LA1_RK4(f, tspan, h, x0);

subplot(2,2,3);
hold on
plot(t_case3, x_states_case3(1,:), '-r', 'LineWidth', 1);
plot(t_case3, x_states_case3(2,:), '-b', 'LineWidth', 1);
hold off
grid on;
title('c: negative')
xlabel('Time (in seconds)');
ylabel('Population density');
legend('Prey', 'Predator');

%%%%% Part 4, Case 4: d negative, rest all positive
a=0.8; 
b=0.5; 
c=0.5; 
d=-0.2;

f = @(t,x)([a*x(1) - b*x(1)*x(2) ; c*x(1)*x(2) - d*x(2)]);
[t_case3 x_states_case3] = LA1_RK4(f, tspan, h, x0);

subplot(2,2,4);
hold on
plot(t_case3, x_states_case3(1,:), '-r', 'LineWidth', 1);
plot(t_case3, x_states_case3(2,:), '-b', 'LineWidth', 1);
hold off
grid on;
title('d: negative')
xlabel('Time (in seconds)');
ylabel('Population density');
legend('Prey', 'Predator');

fprintf("Q1, Part 4: \nThe impact of the change in sign on the population can be observed in the plots.\n The Lotka Volterra model with positive parameters predicts oscillatory behaviour of prey and predator populations which has good evidence in the real world. \nBut with any one negative parameters, The model predicts wrong population densities. That is, the plotted population densities are not seen in nature.\n");




