function [err,sol_x]=ComputeFeasiblePoint(n,k,Aineq,bineq,x_start)
%FeasibilityCheckMIQP Checkes if there exists a feasible point within the current box

clear model;

% Initialize model
model.modelsense = 'min';
model.modelname = 'ComputeFeasiblePoint';

% Variables
model.vtype = [repmat('I',1,k),repmat('C',1,n-k),'C'];

% Objective function
model.obj = [zeros(1,n),0];

% Constraint functions
% Linear constraints
if isempty(bineq)
    Aineq = zeros(1,n+1);
    bineq = 0;
else
    size_Aineq = size(Aineq,1);
    Aineq = [Aineq,-ones(size_Aineq,1)];
end
model.A = sparse(Aineq);
model.rhs = bineq;
model.sense = '<';

% Upper and lower bounds
model.lb = -Inf(n+1,1);
model.ub = Inf(n+1,1);

% Starting point
model.start = [x_start;1];

% Write model
gurobi_write(model, 'FeasibilityCheckMIQP.lp');

% Solve model and return results
clear params;
params.outputflag = 0;
result = gurobi(model, params);
if strcmp(result.status,'OPTIMAL')
    exitflag = 1;
    sol_x = result.x; %TODO: Abgleich mit originalem GurobiCall wegen Dimension
elseif strcmp(result.status,'INFEASIBLE')
    exitflag = -1;
    sol_x = 1;
else
    exitflag = -2;
    sol_x = -1;
end
err = sol_x(end);
sol_x = sol_x(1:end-1);
end