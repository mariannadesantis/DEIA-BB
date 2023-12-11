function [time,nnodes,w,cardL,SetU] = CallTest_DEIABB(param,problem_name)


%% Please enter your parameters below
% Your Problem
%problem_name = 'SparseRandom';
%param = [20,0.5,2,15,03677];

%% DOPIF part
% Should results be saved or plotted?
plotDEIABB = 0;
saveDEIABB = 0;

% Hyperplanes to use (except unit vectors)
%H = []; % two hyperplanes
%H = [1;1]; % three hyperplanes
%H =  [1,1;0.25,0.75;0.75,0.25]'; % five hyperplanes
H =  [0.5,0.5;0.25,0.75;0.75,0.25;0.1,0.9;0.9,0.1;0.2,0.8;0.8,0.2;0.3,0.7;0.7,0.3]'; % eleven hyperplanes

% Call Solver
[SetL,SetU,nnodes,ExpiredTimeFlag,time]=callDEIABB(problem_name,param,H,3600,saveDEIABB,plotDEIABB);
 cardL = size(SetL,2);
if (ExpiredTimeFlag == 0)
    L = SetL(:,1);
    for i=2:size(SetL,2)
        [indexlist, add_index] = updateNDS(L,SetL(:,i));
        if add_index
            L = [L(:,indexlist(1:end-1)),SetL(:,i)];
        end
    end
    U = SetU;
    w = computeWidth(L,U);
else %(DEIA-BB reached TIME_LIMIT)
    time = 3600;
end


return