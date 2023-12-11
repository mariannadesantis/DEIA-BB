function [solution_x,solution_t,exitflag] = PSMIQP(n,k,p,Aineq,bineq,Qfun,qfun,cfun,x_start,a,r)
%PSMIQP Pascoletti Serafini Scalarizationn with parameters a,r

clear model;

% Initialize model
model.modelsense = 'min';
model.modelname = 'PSMIQP';

% Variables
model.vtype = [repmat('I',1,k),repmat('C',1,n-k+1)];

% Objective function
model.obj = [zeros(1,n),1];

% Constraint functions
% Linear constraints
if ~isempty(bineq)
    size_Aineq = size(Aineq,1);
    model.A = sparse([Aineq,zeros(size_Aineq,1)]);
    model.rhs = bineq;
    model.sense = '<';
end
% Quadratic constraints
for j=1:p
    model.quadcon(j).Qc=sparse([Qfun{j},zeros(n,1);zeros(1,n+1)]);
    model.quadcon(j).q=[qfun{j};-r(j)];
    model.quadcon(j).rhs=a(j)-cfun{j};
    model.quadcon(j).sense='<';
    model.quadcon(j).name=['ps_constraint_',num2str(j)];
end

% Starting point
model.start = [x_start;0];

% Upper and lower bounds
model.lb = [-Inf(n,1);0];
model.ub = Inf(n+1,1);

% Write model
gurobi_write(model, 'PSMIQP.lp');

% Solve model and return results
clear params;
params.outputflag = 0;
% params.DualReductions = 0;
result = gurobi(model, params);
if strcmp(result.status,'OPTIMAL')
    exitflag = 1;
    sol = result.x;
elseif strcmp(result.status,'INFEASIBLE')
    exitflag = -1;
    sol = -ones(n+k+1);
elseif isfield(result,'x')
    exitflag = 0;
    sol = result.x;
else
    exitflag = -2;
    sol = -ones(n+k+1);
end
solution_x = sol(1:end-1);
solution_t = sol(end);
end