function [c, ceq] = confun(x)
d12=512;
d23=470;
d34=1325;
d45= 1733;
d56= 483;
d67= 1415;
d78= 260;
d89 = 486;
p=4;
% Nonlinear inequality constraints
max_v=24;
min_v=12;

t1=0;
t2=d12/x(1)+t1+p+3;
t3=d23/x(2)+t2+p+3;
t4=d34/x(3)+t3+p+3;
t5=d45/x(4)+t4+p+4;
t6=d56/x(5)+t5+p+2;
t7=d67/x(6)+t6+p+2;
t8=d78/x(7)+t7+p+4;
t9=d89/x(8)+t8+p+4;




c = [

        t1;
       t2-44;
       t3-84;  
       t4-170;  
       t5-286;  
       t6- 333;
       t7-427;
       t8-465;
       t9-506;
                   %right time interval 
         -t1;
         26-t2;
         66-t3; 
         152-t4;
         268-t5;
         315-t6;
         409-t7;
         447-t8;
         488-t9;
                  %left time interval

    

         x(1)-max_v;
         x(2)-max_v;
         x(3)-max_v; 
         x(4)-max_v;
         x(5)-max_v;
         x(6)-max_v;
         x(7)-max_v;
         x(8)-max_v;
         
                  %maximun speed
         min_v-x(1);
         min_v-x(2);
         min_v-x(3);
         min_v-x(4);
         min_v-x(5);
         min_v-x(6);
         min_v-x(7);
         min_v-x(8);
         
                 %minimum speed
   
         ];
% Nonlinear equality constraints
ceq = [];