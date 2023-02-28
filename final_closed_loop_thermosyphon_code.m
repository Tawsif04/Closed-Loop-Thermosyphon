format long;

eff=4.1;
k=398;
L1=25e-3;
%%A=0.45e-3*L1;%%
h=100;     %%convection coeff%%
t=0.45e-3; %%thickness%% 

fin_width=0.055;

Cp=4181;

max_temp=54;
t_atm=30;
req_temp=45;

tube_dia=12.7e-3;

perimeter= 2*(fin_width+t);
cross_area=fin_width*t;
m=sqrt((h*perimeter)/(k*cross_area));

fin_eff=tanh(m*L1)/(m* L1);



finned_area= 2 * L1 *fin_width;


unfinned_tube=3.14*(tube_dia)*((2*0.125)+(3.14*(tube_dia/2))); 



unfinned_area= unfinned_tube-((tube_dia/2)*3.14*t*2);
a=((tube_dia/2)*3.14*t*2);
Q_finned= fin_eff *h *finned_area * (max_temp-t_atm);

Q_unfinned=h * unfinned_area * (max_temp-t_atm);

Q_total= Q_unfinned +  Q_finned; 

Q_no_fin=h*unfinned_tube*(max_temp-t_atm);

fin_number=((eff*Q_no_fin)-h*(max_temp-t_atm)*unfinned_tube)/((Q_finned)-h*a*(max_temp-t_atm));

fin_number=ceil(fin_number);



thermosyphon_eff= ((eff*Q_no_fin)/150)*100;

mass_flow_rate= Q_total/(Cp*(max_temp-req_temp));


%%air mass flow rate%%

fan_capacity=0.0142; %% in cubic meter per second
mass_flow_rate_air=1.164*fan_capacity;
final_temp_air=(Q_total/(1007*mass_flow_rate_air))+t_atm;


%%calculating overall heat trasnfer coeff%%

T1= max_temp-final_temp_air;
T2=req_temp-t_atm;

LMTD=(T1-T2)/(log(T1/T2));

factor=0.95;
overall_heat_transfer_coeff=Q_total/(3.14*tube_dia*0.27*0.95*LMTD);

