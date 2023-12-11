function [alpha,beta]=ComputeAlphaBeta(n,p,l,lambda,Qi,cr,Ac,d)

% Compute xstar
xstar = zeros(n-d,p+l);
for h = 1:p+l
    xstar(:,h) = -0.5*Qi{h}*(cr{h} + Ac'*lambda{h});
end

% Compute values for alpha)d+1) and beta(d+1)
alpha = min(xstar(1,:));
alpha = floor(alpha);
beta = max(xstar(1,:));
beta = ceil(beta);