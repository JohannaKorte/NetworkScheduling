% ASSIGNMENT I - Problem 2
%
% TU Delft 2018
%
% Johanna Korte
% Carmen Velarde
%--------------------------------------------------------------------------
% DATA
%--------------------------------------------------------------------------
clear all; close all; clc;

datafile='Input_AE4424_Ass1P2.xlsx'; 

%Load excel data 
[x_Flight_num, x_Flight_txt, x_Flight_raw] = xlsread(datafile,'Flight','A2:F233');
[x_Itinerary_num, x_Itinerary_txt, x_Itinerary_raw] = xlsread(datafile,'Itinerary','A2:G738');
x_RecapRate = xlsread(datafile,'Recapture Rate','A2:E300');

%Flight Number
flight_num = x_Flight_txt(:,1);

%Arcs
flight_arcs = x_Flight_txt(:,2:3);
num_arcs = length(flight_arcs(:,1));

%Capacity 
capacity = x_Flight_num(:,3); 

%Itinerary Number
it_no = x_Itinerary_num(:,1);

%Itineraries
itineraries = x_Itinerary_txt(:,1:2);

%Itinerary demand
it_demand = x_Itinerary_num(:,4);

%Itinerary fare
it_fare = x_Itinerary_num(:,5); 

%Itinerary legs
it_legs = x_Itinerary_raw(:,6:7); 

%Recap rates
recap_rate = x_RecapRate(:,1:3); 

%__________________________________________________________________________
%Build network excluding duplicate arcs 
airports = union(flight_arcs(:,1), flight_arcs(:,2));

%Assign node numbers to arcs  
O_arc = zeros(2*num_arcs,1); 
D_arc = zeros(2*num_arcs,1);

for i=1:num_arcs
    % Origin
    O_arc(i) = find(strcmp(airports, flight_arcs{i,1}));
    O_arc(i+num_arcs) = find(strcmp(airports, flight_arcs{i,2}));
    % Destination
    D_arc(i) = find(strcmp(airports, flight_arcs{i,2}));
    D_arc(i+num_arcs) = find(strcmp(airports, flight_arcs{i,1}));
end

%remove duplicates
OD_arcs = unique([O_arc, D_arc], 'rows');
O_arc = OD_arcs(:,1);
D_arc = OD_arcs(:,2); 
num_arcs_unique = length(OD_arcs(:,1));

%Build network
Network = digraph(O_arc, D_arc, 1, airports); 
plot(Network);

%__________________________________________________________________________
% Give numbers to itineraries (commodities)
num_itineraries = length(itineraries(:,1));

O_it = zeros(num_itineraries,1); 
D_it = zeros(num_itineraries,1);

for i=1:num_itineraries
    % Origin
    O_it(i) = find(strcmp(airports, itineraries{i,1}));
    % Destination
    D_it(i) = find(strcmp(airports, itineraries{i,2}));
end

save('Data_prob2')
