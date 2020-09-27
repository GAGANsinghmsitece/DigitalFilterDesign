clc;
close;
clear all;
%% Problem Defintion
%problem.costFunction=@(x)Sphere(x);
problem.costFunction=@(currentFilterPosition,desiredFilter_h)CostFunction(currentFilterPosition,desiredFilter_h);
problem.nVar=1;     % number of unknown Variables
problem.VarMin=-1; %lower bound
problem.VarMax=1;  %upper bound
problem.order=31;
problem.desiredFilter=fir1(31,0.5,kaiser(32,8));%create a filter of order 31 using kaiser window technique

%% Parameters of PSO
params.MaxIt=1000;          %number of iterations
params.nPop=50;             %Population size
params.w=1;                 %inertial coefficent
params.wdamp=0.09;          %damping ratio of inertial coefficient
params.c1=2;                %personal acceleration coefficient
params.c2=2;                %social acceleration coeffeicient
params.ShowIterInfo=true;   %flag for showing info after each iteration
params.isfirstPrint=false;  %will not print the result of first iteration
%% Calling PSO
out=PSO(problem,params);
BestSol=out.BestSol;
BestCosts=out.BestCosts;

%% Results
%plot(BestCosts,'LineWidth',2);
subplot(1,2,2);
semilogy(BestCosts,'LineWidth',2);
xlabel('Iteration');
ylabel('Best Cost');
grid on;