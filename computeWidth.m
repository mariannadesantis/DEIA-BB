function w = computeWidth(L,U)
%computeWidth computes the width of an enclosure corresponding to the input
%sets L and U of lower and upper bounds

%% Initialization
w = 0;

%% Computation
for l=L
    U_l = ~any(l>U);
    if any(U_l)
        w_l = max(min(U(:,U_l)-l));
        if w_l > w
            w = w_l;
        end
    end
end

end