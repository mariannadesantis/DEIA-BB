function [sol_x,ideal]=computeIdealPoint(n,p,Qfun,cfun,afun,Aineq,bineq,x0)
%computeIdealPoint Computes the ideal point of the integer relaxed problem

% Solver options
options = optimoptions('quadprog','Display','none');

% Initialization of return values
sol_x = zeros(n,p);
ideal = zeros(p,1);

for j=1:p
    [sol_x(:,j),fval] = quadprog(Qfun{j},cfun{j},Aineq,bineq,[],[],[],[],x0,options);
    ideal(j) = fval + afun{j};
end
end