function [Q,c,a,Qinv,Qtilde,cpar,eigmaxQ]=PreProcessing(n,k,p,l,Qfun,cfun,afun,Aineq,H)

% Initialization
Q = cell(p+l,k+1);
c = cell(p+l,k+1);
a = cell(p+l,1);
Qinv=cell(p+l,k+1);
Qtilde = cell(p+l,k+1);
cpar = cell(p+l,k+1);
eigmaxQ = cell(p+l,k+1);
A = cell(1,k+1);

% Construct submatrices of A for easier understanding
for d=1:k+1
    A{d}=Aineq(:,d:n);
end

% Preprocessing for the hyperplanes corresponding to the unit vectors
for h=1:p
    for d=1:k+1
        Q{h,d}=Qfun{h}(d:n,d:n);
        Qinv{h,d}= inv(Q{h,d});
        cpar{h,d}= Qinv{h,d}*A{d}';
        Qtilde{h,d} = -0.25*(A{d}*cpar{h,d});
        eigmaxQ{h,d} = eigs(-Qtilde{h,d},1);
        c{h,d}=cfun{h}(d:n);
    end
    a{h} = afun{h};
end

% Preprocessing for the remaining hyperplanes
for idx=1:l
    h = p + idx;
    nv = H(:,idx);
    for d=1:k+1
        Q{h,d}=nv(1).*Q{1,d};
        c{h,d}=nv(1).*c{1,d};
        a{h}=nv(1).*a{1};
        for j=2:p
            Q{h,d}=Q{h,d}+nv(j).*Q{j,d};
            c{h,d}=c{h,d}+nv(j).*c{j,d};
            a{h}=a{h}+nv(j).*a{j};
        end
        Qinv{h,d}= inv(Q{h,d});
        cpar{h,d}= Qinv{h,d}*A{d}';
        Qtilde{h,d} = -0.25*(A{d}*cpar{h,d});
        eigmaxQ{h,d} = eigs(-Qtilde{h,d},1);        
    end
end
end

