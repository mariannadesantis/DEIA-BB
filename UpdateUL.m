function [SetU,SetL]=UpdateUL(lambda,ott,f,Qi,cr,Ac,p,SetU,SetL,Qtilde,ctilde,atilde,eigmaxQ,xfix,k,tt,TIME_LIMIT)

ideal_point = zeros(p,1);
H = eye(p);
for h = 1:p
    if(ott(h)==0)
        %In order to get a minimization problem, we change the signs of
        %every term in the o.f. of the dual subproblem:
        [ott(h),lambda{h},~] = FASTQPA(-Qtilde{h,k+1},-ctilde{h},-atilde{h},eigmaxQ{h,k+1},lambda{h},1e10,tt,TIME_LIMIT);
    end
    xstarh = -0.5*Qi{h}*(cr{h} + Ac'*lambda{h});
    xf = [xfix; xstarh];
    ideal_point(h) = H(:,h)'*f(xf);
    
    % Update the local upper bound set
    SetU = updateLUB3(SetU,f(xf));
end

% Add the ideal point to the lower bounds set
 SetL =[SetL, ideal_point];
%[indexlist, add_index] = updateNDS(SetL,ideal_point);
%if add_index
%    SetL = [SetL(:,indexlist(1:end-1)),ideal_point];
%end
end