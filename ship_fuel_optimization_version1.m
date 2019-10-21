tic
Dis=[512, 470,1325, 1733, 483, 1415, 260, 486];
Time_min=[0, 26, 66, 152, 268, 315, 409, 447, 488];
Time_max=[0, 44,84, 170, 286, 333, 427, 465, 506];
Parking_time=[0,3,3,3,4,2,2,4,4];
Service_time=4;

Speed=[12,24];

discrete_gap_1=3;

[arrive_time_1,speed_seq_1,fuel_1,graph_1] = ShipFuel_ShortestPath(Dis,Time_min,Time_max,Parking_time,Service_time,Speed,discrete_gap_1);
% view graph 
h = view(biograph(graph_1,[],'ShowWeights','on'));

Time_min_new=[];
Time_min_new(1)=0;
Time_min_new(2:1+length(arrive_time_1))=arrive_time_1-discrete_gap_1;
Time_min_new=max(Time_min_new,Time_min);
Time_max_new=[];
Time_max_new(1)=0;
Time_max_new(2:1+length(arrive_time_1))=arrive_time_1+discrete_gap_1+Parking_time(2:end)+Service_time;
Time_max_new(end)=Time_max_new(end)+discrete_gap_1/2;
Time_max_new=min(Time_max_new,Time_max);
discrete_gap_2=0.5;

[arrive_time,speed_seq,fuel,graph] = ShipFuel_ShortestPath(Dis,Time_min_new,Time_max_new,Parking_time,Service_time,Speed,discrete_gap_2);
% view graph 
%h2 = view(biograph(graph,[],'ShowWeights','on'));
toc
