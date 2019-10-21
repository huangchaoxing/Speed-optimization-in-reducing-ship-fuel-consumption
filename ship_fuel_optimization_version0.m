tic
Dis=[512, 470,1325, 1733, 483, 1415, 260, 486];
Time_min=[0, 26, 66, 152, 268, 315, 409, 447, 488];
Time_max=[0, 44,84, 170, 286, 333, 427, 465, 506];
Parking_time=[0,3,3,3,4,2,2,4,4];
Service_time=4;

Speed=[12,24];

discrete_gap_1=0.5;

[arrive_time_0,speed_seq_0,fuel_0,graph_0] = ShipFuel_ShortestPath(Dis,Time_min,Time_max,Parking_time,Service_time,Speed,discrete_gap_1);
 %view graph 
h = view(biograph(graph_0,[],'ShowWeights','on'));
toc