% ASSIGNMENT Ib:  Pax Mix Flow
%
% TU Delft 2018
%
% Johanna Korte
% Carmen Velarde
%--------------------------------------------------------------------------
% DATA for validation 
%--------------------------------------------------------------------------

clear all; close all; clc;
% Note: All arrays are writen in columns.
%flight_no:array of flight numbers
%num_flights: number of flights in total
%capacity: array of flight capacities
flight_no={'301','102','101','302','201','202'};
num_flights=length(flight_no); 
capacity= [180 144 144 108 108 108]';

%legs = [leg1,leg2]
legs={'301',' ';'301','101';'102',' ';'102','302';'101',' ';'302',' ';'201',' ';'202',' ';}; 
legs=[legs;["", ""]]; %Add ficticious 

%It = [no., demand, fare]
it(:,1)=1:8;
it(:,2)=[90 40 90 50 100 80 120 100];

it=[x_Itinerary_num(:,1),x_Itinerary_num(:,4),x_Itinerary_num(:,5)]; 
it=[it;[738,10000,0]]; %Add ficticious itinerary with unlimited demand
num_it=length(it(:,1)); 

% Add fictitius itinerary to recaptures
ficticious=zeros(num_it,5); 
ficticious(:,2)=738; %Destination itinerary is 738 for now, because an itinerary 0 already exists
ficticious(:,3)=1; %Recap rate, all people are willing to recap to this one
for i=1:num_it
    ficticious(i,1)=i-1; %Origin itinerary 
    ficticious(i,4)=it(i,3); %Fare of preferred itinerary
end 

%Recap = [From It, To It, b, Fare 'From', Fare 'To']
recap_rate = x_RecapRate(:,1:5); 
recap_rate=[ficticious;recap_rate];
num_recap = length(recap_rate(:,1)); 

%Set of already included columns
Set = linspace(1,737,737); 
save('test_prob2')

%Delta matrix, which flight legs part of which itineraries 
delta=zeros(num_flights,num_it); 
for f=1:num_flights
    fnum = flight_no(f); 
    for i=1:num_it
        leg1 = legs(i,1);
        leg2 = legs(i,2);
        % If flight leg part of itinerary, add itinerary demand and add to
        % Delta matrix as 1 
        if fnum==leg1
            delta(f,i)=1;
        elseif fnum==leg2
            delta(f,i)=1; 
        end   
    end
end 
