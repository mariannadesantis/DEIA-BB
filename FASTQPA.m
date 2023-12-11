function [ott,x,fstar] = FASTQPA(Q, c, a, lmax, x0, ub,t2,TIME_LIMIT)
n = size(c, 1);
maxit=1000;%0;
%eps=10^-10;
eps=10^-5;
epsstima=min(10^(-5),1/(lmax));
it=1;
%Starting point
%x=zeros(n,1);
x = x0;

actold=zeros(n,1);
ax=zeros(n,1);

x1 = x;
%Gradient computation
g= 2*Q*x + c;
%Projected gradient at starting point x=0
gradproj = max(0, x - g)-x;
 %Function computation:
f = x'*Q*x + c'*x + a;
ott = 0;

if ((norm(gradproj,inf)<=eps)||(-f >= ub + 10^-5))
    stop = 0;
else
    stop = 1;
end
%main iteration
while ((it<=maxit) && (stop) && (t2+toc< TIME_LIMIT))
    tt = t2+toc;
    %Active set estimation:
    act=( x <= epsstima.*g );
    %Non-active set:
    nact=( x > epsstima.*g );
    %Set to zero the estimated active variables:
    %ax=xor(act,actold);
    x(act)=0.0;
    x1 = x;
    xn= x(nact);
    c1= c(nact);
    g1= g(nact);
    
    Q1 = Q(nact, nact);
    
    %Function computation:
    f = xn'*Q1*xn + c1'*xn;
    
    %Armijo monotone linesearch on projected
    %Conj grad direction:
    [x,d] = conjgrad(n, x, x1, xn, nact, Q1, c1, g1, f, TIME_LIMIT);
    %lengnact = length(nact)
    %dnorm = norm(d,2)
    %xnorm = norm(x,2)
    %pause
    
    actold=act;
    
    %Gradient computation:
    if( size(x,2) == n )
        x= x';
    end
    g = 2*Q*x + c;
    
    
    if( size(g,2) == n )
        g= g';
    end
    
    %Projected gradient:
    
    gradproj = max(0, x - g) - x;
    
    gnorm = norm(gradproj,inf);
    
    if ((gnorm<=eps)||(norm(d,2)<=eps)||(-f >= ub + 10^-5))
        stop = 0;
        %time = toc;
        ott = 1;
        if(f >= ub + 10^-5)
            ott = 0;
        end
    end
    it = it+1;
    
end

%if( size(x,2) == n )
%    x= x';
%end

fx= x'* Q*x + c'*x + a;
% In order to get a valid lower bound:
fstar = -fx;

% if (stop == 0)
%     disp('f = ');
%     disp(fx);
%     disp('norm grad_proj = ');
%     disp(norm(gradproj,inf));
%     disp('iteration = ');
%     disp(it);
%     disp('CPU time = ');
%     disp(time);
% else
%     disp('Failure: maximum number of iteration reached');
% end
