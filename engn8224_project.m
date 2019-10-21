Dis=[512, 470,1325, 1733, 483, 1415, 260, 486];
Time_min=[0, 26, 66, 152, 268, 315, 409, 447, 488];
Time_max=[0, 44,84, 170, 286, 333, 427, 465, 506];
Parking_time=[0,3,3,3,4,2,2,4,4];
Service_time=4;

Speed_max=24;
Speed_min=12;

Real_time_window=Time_max-Time_min-Parking_time-Service_time;

discrete_gap=1;

Nodes=[];
Nodes(1)=1;
Nodes(2:9)=fix(Real_time_window(2:9)/discrete_gap)+1;

Out_node=[];
In_node=[];
Weights=[];
time_list=[];
speed_list=[];
k=1;
j=1;
for i=1:8
    if i==1
        low_num=1;
    else
       
        low_num=sum(Nodes(1:i-1))+1;
    end
        
    for m=low_num:sum(Nodes(1:i))
        
        for n=1:Nodes(i+1)
            
            Out_node(k)=m;
            In_node(k)=sum(Nodes(1:i))+n;
            time=Time_min(i+1)+discrete_gap*(n-1)-(Time_min(i)+(m-low_num)*discrete_gap)-Service_time*min(i-1,1)-Parking_time(i);
            time_list(k)=time;
            speed=Dis(i)/time;
            speed_list(k)=speed;
            if speed<Speed_min || speed> Speed_max
                Weights(k)=0;
            else
                Weights(k)=speed^2*Dis(i)/24;
               
            
            end
            k=k+1;
        end
    end
       
end
Out_node(length(Out_node)+1:length(Out_node)+Nodes(9))=[sum(Nodes(1:8))+1:sum(Nodes(1:9))];
In_node(length(In_node)+1:length(In_node)+Nodes(9))=(sum(Nodes(1:9))+1)*ones(1,Nodes(9));
Weights(length(Weights)+1:length(Weights)+Nodes(9))=ones(1,Nodes(9));

Out_node(length(Out_node)+1)=sum(Nodes(1:9))+1;
In_node(length(In_node)+1)=1;
Weights(length(Weights)+1)=1;

DG = sparse(Out_node,In_node,Weights);
[dist,path,pred] = graphshortestpath(DG,1,Out_node(end));
%MG=sparse([1,1,2,3,4],[2,3,4,4,1],[1,0,1,0,0]);

