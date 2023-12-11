%%% Numerical tests for the comparison of PI-AdEnA vs AdeNa %%%

%% Some clean-up first
clear;
close all;
clc;

%% Adding paths
format long;
rng(03677,'twister')
addpath('savefiles')
%addpath('problems')


fileID = fopen('DEIA-BB_res.txt','w');


fprintf(fileID, [' n & m & int & dens & seed & time & nodes & width & card L \\\\ \r\n']);
formatSpec = '%3.0d & %3.0d & %8.2f & %8.2f & %5.0d & %8.4f & %3.0d  & %8.4f  & %3.0d\\\\ \r\n';


problem_name = 'SparseRandom';

% Set parameters:
n = 10; m = 15; k = 0.75; dens = 0.75; seed = 102135;
param = [n,k,2,m,seed,dens];
[time,nodes,width,cardL,SetU] = CallTest_DEIABB(param,problem_name);
fprintf(fileID,formatSpec,n,m,k,dens,seed,time,nodes,width,cardL);

