function [xp, d]  = conjgrad(n, x, x1, xn, nact, Q1, c1, g1, f, TIME_LIMIT)

if(sum(nact) == 0)
    xp = x;
    d = 0;
    return
else
    geff = g1;
    xeff=  xn;
end

%! Conjugate gradient:
d1 = -geff;
stopCG = 1;


if ((norm(geff,2)< 10^-4))
    stopCG = 0;
end

dQd = d1'*Q1*d1;
it = 0;

while (stopCG == 1 && (dQd > 1e-5 && ~isnan(dQd)))
    gnorm2 = geff'*geff;
    alpha = gnorm2/dQd;
    z = xeff + alpha*d1;
    gnew = geff + alpha*Q1*d1;
    %! Stopping condition:
    if (norm(gnew,2)< 10^-4)
        stopCG = 0;
        xeff = z;
    else
        beta = (gnew'*gnew)/gnorm2;
        dnew = -gnew + beta.*d1;
        xeff = z;
        geff = gnew;
        d1 = dnew;
    end
    
    if ((norm(geff,2)< 10^-4) || ((toc> TIME_LIMIT)))
        stopCG = 0;
    end
    %Compute dQd
    dQd = d1'*Q1*d1;
    it = it+1;     
end

if(stopCG == 0)
    d = zeros(n,1);
    dd =  xeff - xn;
    d(nact) = xeff - xn;
else
    if(it == 0)
        d = zeros(n,1);
        dd = -geff;
        d(nact) = dd;
    else
        d = zeros(n,1);
        dd =  xeff - xn;
        d(nact) = xeff - xn;
    end
end

if (norm(d,2) < 10^-4)
    xp = x;
   % disp('norm null')
    return
else
    %length(nact)
    %pause
    
    %% linesearch
    alpha=1;
    beta=0.5;
    gamma = 0.01;
    lnot = 1;
    itl = 1;
    epsm = 10^(-8);
    fail = epsm * max(norm(xn,2),10^(-6))/max(1,norm(dd,2));
    while(lnot)
        % Trial point:
        z = max(0, xn + alpha* dd);
        fz = z'*Q1*z + c1'*z;
        if( (fz - f) <= gamma*g1'*(z - xn) )
        %if( (fz - f) <= gamma*g1'*dd)
            lnot=0;
        else
            alpha = beta*alpha;
        end
        if (alpha < fail)
            %disp('linesearch failure');
            %pause
            x1(nact)= z;
            xp = x1;
            return
        end
    end
    x1(nact)= z;
    xp = x1;
    
end
