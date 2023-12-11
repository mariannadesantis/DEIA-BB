function [n,k,p,f,Qfun,cfun,afun,Aineq,bineq,x0,z,Z] = SparseRandom(params)
%SparseRandom A test instance with random entries for Qfun, cfun, afun,
%Aineq and bineq

% Dimension of decision and criterion space
n = params(1); % Total number of variables
k = ceil(n*params(2)); % Integer variables
p = params(3); % Dimension criterion space
%assert(p == 2);
m = params(4);

% Objective function
rng(params(5));
dens = params(6);
for j=1:p
    eigenvalues = rand(n,1)+0.1;
    density = dens; %rand*0.5+0.25;
    Qfun{j} = sprandsym(n,density,eigenvalues);
    cfun{j} = rand(n,1).*2-1;
    afun{j} = 0;
end

f = @(x) [(x'*Qfun{1})*x + cfun{1}'*x + afun{1}; (x'*Qfun{2})*x + cfun{2}'*x + afun{2}];
%f = @(x) [(x'*Qfun{1})*x + cfun{1}'*x + afun{1}; (x'*Qfun{2})*x + cfun{2}'*x + afun{2}...
%    ; (x'*Qfun{3})*x + cfun{3}'*x + afun{3}];
%f = @(x) [(x'*Qfun{1})*x + cfun{1}'*x + afun{1}; (x'*Qfun{2})*x + cfun{2}'*x + afun{2}...
%; (x'*Qfun{3})*x + cfun{3}'*x + afun{3}; (x'*Qfun{4})*x + cfun{4}'*x + afun{4}];

% Linear inequality constraints (Aineq*x <= bineq, Aeq*x = beq)
Aineq = sprand(m,n,0.5).*2-1;
bineq = rand(m,1).*2-1;

% Starting box
z = -1e6.*ones(p,1);
Z = 1e6.*ones(p,1);

% Start point x0
x0 = zeros(n,1);
end