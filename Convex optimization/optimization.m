clc
clear all
tic
x0 = 18.5*ones(1,8);     % Make a starting guess at the solution
options = optimoptions(@fmincon,'Algorithm','sqp');
[x,fval] = ... 
fmincon(@objfun,x0,[],[],[],[],[],[],@confun,options);
toc

 