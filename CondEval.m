function [cond,lambda,ott,phi] = CondEval(p,l,Qtilde,ctilde,atilde,eigmaxQ,U,H_add,phi_init,d,t2,TIME_LIMIT)

% Initialization
m = size(Qtilde{1,d+1},1);
ott = zeros(p+l,1);
lambda = cell(p+l,1);
phi = phi_init;
cond = true;
H = [eye(p),H_add];
for h=1:p+l
    lambda{h} = zeros(m,1);
end


% N.B. lambda is an m-dimensional vector, each component represent the starting point for FASTQPA, 
% in order to solve the j-th subproblem
for u = U
    if min(H'*u - phi) > -1e-6
        cond_u = false;
        for h=1:p+l
            uval = H(:,h)'*u;
            % Call FAST_QPA to solve the dual of the single objective subproblem having f_h as objective function.
            % STOP either if you get the optimal dual solution (= to the primal one) or at the iteration k such 
            % that lambda(k) leads to a value phi(k)>uval
            %
            % N.B: when dealing with a new point in LPNS we would start the optimization of FAST-QPA from lambda(j)
            %      exploiting the iterations already performed for solving the j-th subproblem
            if(ott(h)==0)
                %In order to get a minimization problem, we change the signs of
                %every term in the objective function of the dual subproblem:
                [ott(h),lambda{h},phi(h)] = FASTQPA(-Qtilde{h,d+1},-ctilde{h},-atilde{h},eigmaxQ{h,d+1},lambda{h},uval,t2,TIME_LIMIT);
            else
                continue
            end
            if(uval<phi(h))
                cond_u = true;
                break;
            end
        end
        if ~cond_u
            cond = false;
            break;
        end
    end
end
end
