function plotBoxes(L,U,m)

length_U = size(U,2);
if m < 3
    figure;
    hold on;
    vert_base = [0 0 1 1;0 1 0 1];
    faces = [1 2 4 3 1];
    for l = L
        U_boxes = all(l<U+1e-6);
        if any(U_boxes)
            directions = U(:,U_boxes)-l;
            for r=directions
                patch('Faces',faces,'Vertices',[l+vert_base.*r]','FaceColor','blue','FaceAlpha',.1);
            end
        end
    end
    grid on;
    xlabel('f_1');
    ylabel('f_2');
%     title('Box approximation of the set \{f(x) | x \in S efficient\}');
elseif m < 4
    figure;
    hold on;
    vert_base = [0 0 0 0 1 1 1 1;0 0 1 1 0 0 1 1;0 1 0 1 0 1 0 1];
    faces = [1 2 4 3;3 4 8 7;7 8 6 5;5 7 3 1;1 5 6 2;2 4 8 6];
    for l = L
        U_boxes = all(l<U+1e-6);
        if any(U_boxes)
            directions = U(:,U_boxes)-l;
            for r=directions
                patch('Faces',faces,'Vertices',[l+vert_base.*r]','FaceColor','blue','FaceAlpha',.1);
            end
        end
    end
    grid on;
    xlabel('f_1');
    ylabel('f_2');
    zlabel('f_3');
%     title('Box approximation of the set \{f(x) | x \in S efficient\}');
end
end

