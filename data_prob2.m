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

%flight_no:array of flight numbers
%num_flights: number of flights in total
%capacity: array of flight capacities
flight_no=string(x_Flight_txt(:,1));
num_flights=length(flight_no); 
capacity= x_Flight_num(:,3);

%legs = [leg1,leg2]
legs=string(x_Itinerary_txt(:,5:6)); 

%It = [no., demand, fare]
it=[x_Itinerary_num(:,1),x_Itinerary_num(:,4),x_Itinerary_num(:,5)]; 
num_it=length(it(:,1)); 

%Recap rates
recap_rate = x_RecapRate(:,1:3); 

save('Data_prob2')
