clear
clc

load('PIHyp.mat');

p2 = PIHyp2;
p3 = PIHyp3;
p4 = PIHyp5;

fileID2 = fopen('Comp_p2_avg.txt','w');
%fileID3 = fopen('Comp_p3_avg.txt','w');
%fileID4 = fopen('Comp_p4_avg.txt','w');


fprintf(fileID2, [' n & m & int & time & nodes & width & cardL & time & nodes & width& cardL & time & nodes & width cardL \\\\ \r\n']);
formatSpec = '%3.0d & %3.0d & %3.0d & %8.2f & %8.2f & %8.2f & %8.2f & %8.2f & %8.2f & %8.2f & %8.2f & %8.2f & %8.2f & %8.2f & %8.2f\\\\ \r\n';



for i=1:3
    init = (i-1)*60+1;
    n = i*5;
    m = 2;

    time2_25 = 0; time2_50 = 0; time2_75 = 0; time2_100 = 0;
    time3_25 = 0; time3_50 = 0; time3_75 = 0; time3_100 = 0;
    time4_25 = 0; time4_50 = 0; time4_75 = 0; time4_100 = 0;


    nodes2_25 = 0; nodes2_50 = 0; nodes2_75 = 0; nodes2_100 = 0;
    nodes3_25 = 0; nodes3_50 = 0; nodes3_75 = 0; nodes3_100 = 0;
    nodes4_25 = 0; nodes4_50 = 0; nodes4_75 = 0; nodes4_100 = 0;


    width2_25 = 0; width2_50 = 0; width2_75 = 0; width2_100 = 0;
    width3_25 = 0; width3_50 = 0; width3_75 = 0; width3_100 = 0;
    width4_25 = 0; width4_50 = 0; width4_75 = 0; width4_100 = 0;


    cardL2_25 = 0; cardL2_50 = 0; cardL2_75 = 0; cardL2_100 = 0;
    cardL3_25 = 0; cardL3_50 = 0; cardL3_75 = 0; cardL3_100 = 0;
    cardL4_25 = 0; cardL4_50 = 0; cardL4_75 = 0; cardL4_100 = 0;

    for j = 1:15
        % 25
        time2_25 = time2_25 + p2(init+j-1,6);
        time3_25 = time3_25 + p3(init+j-1,6);
        time4_25 = time4_25 + p4(init+j-1,6);

        nodes2_25 = nodes2_25 + p2(init+j-1,7);
        nodes3_25 = nodes3_25 + p3(init+j-1,7);
        nodes4_25 = nodes4_25 + p4(init+j-1,7);

        width2_25 = width2_25 + p2(init+j-1,8);
        width3_25 = width3_25 + p3(init+j-1,8);
        width4_25 = width4_25 + p4(init+j-1,8);

        cardL2_25 = cardL2_25 + p2(init+j-1,9);
        cardL3_25 = cardL3_25 + p3(init+j-1,9);
        cardL4_25 = cardL4_25 + p4(init+j-1,9);
    end

    time2_25 = time2_25/15;
    time3_25 = time3_25/15;
    time4_25 = time4_25/15;

    nodes2_25 = nodes2_25/15;
    nodes3_25 = nodes3_25/15;
    nodes4_25 = nodes4_25/15;

    width2_25 = width2_25/15;
    width3_25 = width3_25/15;
    width4_25 = width4_25/15;

    cardL2_25 = cardL2_25/15;
    cardL3_25 = cardL3_25/15;
    cardL4_25 = cardL4_25/15;

    for j = 1:15
        % 50
        time2_50 = time2_50 + p2(init+15+j-1,6);
        time3_50 = time3_50 + p3(init+15+j-1,6);
        time4_50 = time4_50 + p4(init+15+j-1,6);

        nodes2_50 = nodes2_50 + p2(init+15+j-1,7);
        nodes3_50 = nodes3_50 + p3(init+15+j-1,7);
        nodes4_50 = nodes4_50 + p4(init+15+j-1,7);

        width2_50 = width2_50 + p2(init+15+j-1,8);
        width3_50 = width3_50 + p3(init+15+j-1,8);
        width4_50 = width4_50 + p4(init+15+j-1,8);

        cardL2_50 = cardL2_50 + p2(init+15+j-1,9);
        cardL3_50 = cardL3_50 + p3(init+15+j-1,9);
        cardL4_50 = cardL4_50 + p4(init+15+j-1,9);

    end

    time2_50 = time2_50/15;
    time3_50 = time3_50/15;
    time4_50 = time4_50/15;

    nodes2_50 = nodes2_50/15;
    nodes3_50 = nodes3_50/15;
    nodes4_50 = nodes4_50/15;

    width2_50 = width2_50/15;
    width3_50 = width3_50/15;
    width4_50 = width4_50/15;

    cardL2_50 = cardL2_50/15;
    cardL3_50 = cardL3_50/15;
    cardL4_50 = cardL4_50/15;

    for j = 1:15
    % 75
        time2_75 = time2_75 + p2(init+30+j-1,6);
        time3_75 = time3_75 + p3(init+30+j-1,6);
        time4_75 = time4_75 + p4(init+30+j-1,6);

        nodes2_75 = nodes2_75 + p2(init+30+j-1,7);
        nodes3_75 = nodes3_75 + p3(init+30+j-1,7);
        nodes4_75 = nodes4_75 + p4(init+30+j-1,7);

        width2_75 = width2_75 + p2(init+30+j-1,8);
        width3_75 = width3_75 + p3(init+30+j-1,8);
        width4_75 = width4_75 + p4(init+30+j-1,8);

        cardL2_75 = cardL2_75 + p2(init+30+j-1,9);
        cardL3_75 = cardL3_75 + p3(init+30+j-1,9);
        cardL4_75 = cardL4_75 + p4(init+30+j-1,9);


    end

    time2_75 = time2_75/15;
    time3_75 = time3_75/15;
    time4_75 = time4_75/15;  
    
    nodes2_75 = nodes2_75/15;
    nodes3_75 = nodes3_75/15;
    nodes4_75 = nodes4_75/15;

    width2_75 = width2_75/15;
    width3_75 = width3_75/15;
    width4_75 = width4_75/15;

    cardL2_75 = cardL2_75/15;
    cardL3_75 = cardL3_75/15;
    cardL4_75 = cardL4_75/15;

    for j = 1:15
     % 100
        time2_100 = time2_100 + p2(init+45+j-1,6);
        time3_100 = time3_100 + p3(init+45+j-1,6);
        time4_100 = time4_100 + p4(init+45+j-1,6);

        nodes2_100 = nodes2_100 + p2(init+45+j-1,7);
        nodes3_100 = nodes3_100 + p3(init+45+j-1,7);
        nodes4_100 = nodes4_100 + p4(init+45+j-1,7);

        width2_100 = width2_100 + p2(init+45+j-1,8);
        width3_100 = width3_100 + p3(init+45+j-1,8);
        width4_100 = width4_100 + p4(init+45+j-1,8);

        cardL2_100 = cardL2_100 + p2(init+45+j-1,9);
        cardL3_100 = cardL3_100 + p3(init+45+j-1,9);
        cardL4_100 = cardL4_100 + p4(init+45+j-1,9);
    end

    time2_100 = time2_100/15;
    time3_100 = time3_100/15;
    time4_100 = time4_100/15;  

    nodes2_100 = nodes2_100/15;
    nodes3_100 = nodes3_100/15;
    nodes4_100 = nodes4_100/15;

    width2_100 = width2_100/15;
    width3_100 = width3_100/15;
    width4_100 = width4_100/15;

    cardL2_100 = cardL2_100/15;
    cardL3_100 = cardL3_100/15;
    cardL4_100 = cardL4_100/15;

    fprintf(fileID2, formatSpec, n, m, 25, time2_25, nodes2_25, width2_25, cardL2_25, time3_25, nodes3_25, width3_25, cardL3_25, time4_25, nodes4_25, width4_25, cardL4_25);
    fprintf(fileID2, formatSpec, n, m, 50, time2_50, nodes2_50, width2_50, cardL2_50, time3_50, nodes3_50, width3_50, cardL3_50, time4_50, nodes4_50, width4_50, cardL4_50);
    fprintf(fileID2, formatSpec, n, m, 75, time2_75, nodes2_75, width2_75, cardL2_75, time3_75, nodes3_75, width3_75, cardL3_75, time4_75, nodes4_75, width4_75, cardL4_75);
    fprintf(fileID2, formatSpec, n, m, 100, time2_100, nodes2_100, width2_100, cardL2_100, time3_100, nodes3_100, width3_100, cardL3_100, time4_100, nodes4_100, width4_100, cardL4_100);
     

end
 
   

