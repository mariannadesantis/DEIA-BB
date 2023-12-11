function [ctilde,atilde,cr] = computefix(n,p,l,Q0,c0,a0,Aineq,bineq,cd,cpard,Qinvd,xfix,d)

% Initialization
m = size(bineq,1);
cr = cell(p+l,1);
ctilde = cell(p+l,1);
atilde = cell(p+1,1);

% Compute the parameters ar, br, and cr for the subproblems when fixing the
% first d variables to xfix
br = bineq(1:m) - Aineq(1:m,1:d)*xfix;

% First consider the subproblems for the hyperplanes corresponding to the
% unit vectors
for h=1:p+l
    c_fix = Q0{h}(1:d,d+1:n)'*xfix;
    a_fix = c0{h}(1:d)'*xfix + xfix'*Q0{h}(1:d,1:d)*xfix;

    ar = a0{h} +a_fix;    
    cr{h} = cd{h} + 2*c_fix;
    
    ctilde{h}= -br - 0.5*cpard{h}'*cr{h};
    atilde{h} = ar - 0.25*cr{h}'*Qinvd{h}*cr{h};
end
end







