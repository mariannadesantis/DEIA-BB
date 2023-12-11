function [SetL,SetU,nnodes,ExpiredTimeFlag,time]=callDEIABB(problem_name,parameter,H,TIME_LIMIT,saveResults,plotResults)

%% Input
problem_file = str2func(problem_name);
[n,k,p,f,Qfun,cfun,afun,Aineq,bineq,~,~,Z] = problem_file(parameter);

%% Prepare folder to save the results
if saveResults
    foldername=strcat(char(datetime('now','Format','yyyy_MM_dd_HH_mm')),'_',problem_name,'_numVar', num2str(n));
    dirct=strcat('savefiles/',foldername);
    mkdir(dirct);
    filename = fullfile(dirct, 'results.txt');
    fileID = fopen(filename, 'w');
    fprintf(fileID, ['Objective function: ', problem_name,  ...
        '\n Number of variables                       ', num2str(n),...
        '\n set time limit                            ', num2str(TIME_LIMIT)]);
end

%% Call DEIA-BB
tic;
%t=cputime; 
[SetL,SetU,nnodes]=DEIABB(n,k,p,f,Qfun,cfun,afun,Aineq,bineq,Z,H,TIME_LIMIT);
time = toc;

%% Save results and create plot
if (time<TIME_LIMIT)
    ExpiredTimeFlag=0;
    if saveResults
        fprintf(fileID, ['\nResults:',...
            '\n Numbers of nodes                                    ', num2str(nnodes), ...
            '\n Computational time for main loop                    ', num2str(time), 's']);

        fclose(fileID);
    end
    %save(strcat(dirct,'/workspace.mat'));
    cardU = size(SetU,2);
    if plotResults
        plot_image(p,SetU,cardU);
    end
    
else
    ExpiredTimeFlag=1;
    if saveResults
        fprintf(fileID, ['\n\nComputational time expired!']);
    end
end

