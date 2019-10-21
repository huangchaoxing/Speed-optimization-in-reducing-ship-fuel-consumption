function [arrive_time,speed_seq,fuel,DG] = ShipFuel_ShortestPath(Dis,Time_min,Time_max,Parking_time,Service_time,Speed_constrain,discrete_gap)
%--------------------------------------------------------------------------
% Calculate the optimal speed, arrival time, and fuel consumption by given 
% shipping sequence, time window, and speed constrain.
%--------------------------------------------------------------------------
% Author: Hanwen Bi
%--------------------------------------------------------------------------
% SYNTAX: [arrive_time,speed_seq,fuel,DG] = ShipFuel_ShortestPath(Dis,Time_min,Time_max,Parking_time,Service_time,Speed_constrain,discrete_gap)
%
% INPUT:
%       Dis         : a 1 by N-1 array, containing the distance between ports 
%                       N is the ports number
%       Time_min    : a 1 by N array, containinng the minmum  varrival time  
%       Time_max    : a 1 by N array, containinng the maximum  varrival time
%                   
%       Parking_time: a 1 by N array, containinng the parking time of ports
%
%       Speed_constrain: [speed_min, speed_max]
%       Service_time   : service time which is related to ship type
%       discrete_gap   : the discrete gap 
%
% OUTPUT:
%       arrive_time    : the arrival time of ports 2 to N
%       speed_seq      : Average speed between two neighbour ports
%       fuel           : The optimal fuel cost 
%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
% Version history:
% 19.09.2019 - First realsed (Hanwen Bi)
%--------------------------------------------------------------------------


N=length(Time_min);
Speed_max=Speed_constrain(2);
Speed_min=Speed_constrain(1);

% calculate the real time window 
Real_time_window=Time_max-Time_min-Parking_time-Service_time;

% calculate the number of nodes for each port 
Nodes=[];
Nodes(1)=1;
Nodes(2:N)=fix(Real_time_window(2:N)/discrete_gap)+1;

% the outgoing nodes for each arc 
Out_node=[];
% the incoming nodes for each arc 
In_node=[];
% weights for arc
Weights=[];
% travelling time between two neighbour arcs 
time_list=[];
% average speed duing each arc 
speed_list=[];

k=1;
% the links between nodes index and ports index
node_to_port=[];
% the links between arc indesx and related speed 
arc_to_speed=cell(1,sum(Nodes(1:N)));

% calculate the arc index and weight 
for i=1:(N-1)
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
            arc_to_speed{m}(sum(Nodes(1:i))+n)=speed;
            speed_list(k)=speed;
            % judge whehter speed is out of the given range
            if speed<Speed_min || speed> Speed_max
                Weights(k)=0;
            else
                Weights(k)=speed^2*Dis(i)/24;
               
            
            end
            
            k=k+1;
        end
        node_to_port(m)=i;
    end
       
end

% add a imagine nodes for shortest path solver 
Out_node(length(Out_node)+1:length(Out_node)+Nodes(N))=[sum(Nodes(1:(N-1)))+1:sum(Nodes(1:N))];
In_node(length(In_node)+1:length(In_node)+Nodes(N))=(sum(Nodes(1:N))+1)*ones(1,Nodes(N));
Weights(length(Weights)+1:length(Weights)+Nodes(N))=ones(1,Nodes(N));
node_to_port(length(node_to_port)+1:length(node_to_port)+Nodes(N))=N*ones(1,Nodes(N));

% for DG calculation 
Out_node(length(Out_node)+1)=sum(Nodes(1:N))+1;
In_node(length(In_node)+1)=1;
Weights(length(Weights)+1)=0;

% solve the shortest path 
DG = sparse(Out_node,In_node,Weights);
[dist,path,pred] = graphshortestpath(DG,1,Out_node(end));
arrive_time=[];

% get outputs 
for i=1:N-1
    speed_seq(i)=arc_to_speed{path(i)}(path(i+1));
    port=node_to_port(path(i+1));
    arrive_time(i)=Time_min(port)+(path(i+1)-sum(Nodes(1:port-1))-1)*discrete_gap;
end
fuel=(dist-1)*0.0236;

end

