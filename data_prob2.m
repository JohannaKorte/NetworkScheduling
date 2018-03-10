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

datafile='Input_AE4424_Ass1P2.xlsx'

%Load excel data 
[x_Flight_num, x_Flight_txt, x_Flight_raw] = xlsread(datafile,'Flight','A2:F233');
[x_Itinerary_num, x_Itinerary_txt, x_Itinerary_raw] = xlsread(datafile,'Itinerary','A2:G738');
x_RecapRate = xlsread(datafile,'Recapture Rate','A2:E300');

%Flight Number
flight_num = x_Flight_txt(:,1);

%Arcs
flight_arcs = x_Flight_txt(:,2:3);

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

save('Data_prob2')
