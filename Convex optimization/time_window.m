d12=512;
d23=470;
d34=1325;
d45=1733;
d56=483;
d67=1415;
d78=260;
d89=486;
cruise_v=18.5;
dist=[d12,d23,d34,d45,d56,d67,d78,d89];
start_service=zeros(9,1);
end_service=zeros(9,1);
time_change=ceil(linspace(-5,5));
window_size=[0,18,18,18,18,18,18,18,18];

for i=2:9
    changing=datasample(time_change,1);
    start_service(i)=end_service(i-1)+ceil(dist(i-1)/cruise_v)+changing;
    end_service(i)=start_service(i)+window_size(i);
    
end
