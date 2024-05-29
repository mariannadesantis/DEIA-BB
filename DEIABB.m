function [SetL,SetU,nnodes]=DEIABB(n,k,p,f,Qfun,cfun,afun,Aineq,bineq,Z,H,TIME_LIMIT)

%% Initialization
alpha = -10^5*ones(k,1);
beta = 10^5*ones(k,1);
r=alpha;
x=zeros(n,1);
d=0;
l = size(H,2);
nnodes=0;
ctilde = cell(p+l,1);
atilde = cell(p+l,1);
cr = cell(p+l,1);
phi = -10^10.*ones(p+l,k+2);
SetU = Z;
SetL = [];

%% Preprocessing
% In the preprocessing phase we compute Q, Qinv, c, Qtilde, ctilde, atilde
% for every level d, dropping the first d entries
tic;
[Q,c,a,Qinv,Qtilde,cpar,eigmaxQ]=PreProcessing(n,k,p,l,Qfun,cfun,afun,Aineq,H);

%% Handling of d=0
% Compute the parameters for the dual problems
for h = 1:p+l
    ctilde{h} = -bineq - 0.5*cpar{h,1}'*c{h,1};
    atilde{h} = -0.25*c{h,1}'*Qinv{h,1}*c{h,1} + a{h};
    cr{h} = c{h,1};
end

% Check for infeasibility of the root node (i.e. integer relax problem)
% root node infeasible <==> cond = true
tt = toc;
[cond,lambda,~,phi(:,d+2)] = CondEval(p,l,Qtilde,ctilde,atilde,eigmaxQ,SetU,H,phi(:,d+1),d,tt,TIME_LIMIT);
if cond
    warning('Your problem is infeasible.');
    SetL = SetU;
else
    d = 1;
    [alpha(1),beta(1)] = ComputeAlphaBeta(n,p,l,lambda,{Qinv{:,1}},cr,Aineq(:,1:n),0);
    r(1)=alpha(1);
    x(1)=r(1);
end

%% Main loop
while (d>0)
    t1 = toc;
    if(t1>TIME_LIMIT)
        break
    end
    nnodes = nnodes+1;
    
    % Compute ctilde and atilde for the dual problems based on the current
    % fixing of integer variables
    xfix = x(1:d);
    [ctilde,atilde,cr] = computefix(n,p,l,{Q{:,1}},{c{:,1}},a,Aineq,bineq,{c{:,d+1}},{cpar{:,d+1}},{Qinv{:,d+1}},xfix,d);

    
    % Check if the pruning condition (Cond) holds; We also detect
    % infeasibility at this stage which would also lead to cond = true
    t2 = toc;
    [cond,lambda,ott,phi(:,d+2)] = CondEval(p,l,Qtilde,ctilde,atilde,eigmaxQ,SetU,H,phi(:,d+1),d,t2,TIME_LIMIT);
    
    % If we cannot prune, we compute the bounds alpha(d+1), beta(d+1) for
    % the integer fixings of the next (deeper) level or update the lower
    % and upper bound sets in case we have reached a leaf node
    if ~cond
        if (d==k)
            tt = toc;
            % Update the local upper bound set U and the collection of
            % ideal points L
            [SetU,SetL]=UpdateUL(lambda,ott,f,{Qinv{:,d+1}},cr,Aineq(:,d+1:n),p,SetU,SetL,Qtilde,ctilde,atilde,eigmaxQ,xfix(1:k),k,tt,TIME_LIMIT);
        else
            %Compute xstar, alpha(d+1) and beta(d+1) - note that xstar is
            %computed starting from the dual solution applying the closed
            %formula (see paper)
            [alpha(d+1),beta(d+1)] = ComputeAlphaBeta(n,p,l,lambda,{Qinv{:,d+1}},cr,Aineq(:,d+1:n),d);
        end
    end
    
    % Check which node to explore next
    if(cond)&&(r(d)<alpha(d))
        % In this case we have examined all nodes at level d that we could
        % not prune and can return to level d-1
        d=d-1;
        if(d>0)
            [r(d),x(d)]=Updaterd(r(d),alpha(d));
        else
            break
        end
    elseif(cond)&&(r(d)>=alpha(d))
        if(r(d)>=beta(d))
            % Since we can prune all siblings further to the right, we move
            % on to the siblings on the left
            if(d>0)
                x(d) = alpha(d)-1;
                r(d) = x(d);
            else
                break
            end
        else
            % We move further to the right on level d of the branching tree
            x(d)=r(d)+1;
            r(d)=x(d);
        end
    else
        % We cannot prune by (Cond) or (Inf) and hence move on to the next
        % (deeper) level. In case we have already reached level k (leaf
        % node), we move on to the next leaf node
        if (d<=k-1)
            d=d+1;
            r(d)=alpha(d);
            x(d)=r(d);
        else
            [r(d),x(d)]=Updaterd(r(d),alpha(d));
        end
    end
end
end

