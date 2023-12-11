# DEIA-BB
DEIA-BB is a branch-and-bound method for multiobjective mixed-integer convex quadratic programs able to compute a superset of efficient integer assignments and a coverage of the nondominated set.

This folder contains the MATLAB implementation of DEIA-BB used to produce the numerical results in the manuscript:
"Using dual relaxations in multiobjective mixed-integer quadratic programming" by Marianna De Santis,Gabriele Eichfelder,Daniele Patria,Leo Warnow
https://optimization-online.org/?p=23303

The main code is the DEIABB.m file.
FASTQPA.m is a MATLAB implementation of the active-set method used to address the dual subproblems at the nodes.

In order to call DEIA-BB you can use the file RunDEIABB.m (and set the parameters as you like).
The SparseRandom.m file is called in order to build a random instance with:
n = number of variables,
m = number of constraints,
p = number of objective functions,
k = percentage of integer variables,
dens = density of the matrices in the objective functions,

Have fun! :-)
