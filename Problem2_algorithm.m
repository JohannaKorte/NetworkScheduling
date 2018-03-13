% ASSIGNMENT I - Problem 2
%
% TU Delft 2018
%
% Johanna Korte
% Carmen Velarde
%--------------------------------------------------------------------------
% Combined Column and Row generation Algorithm 
%--------------------------------------------------------------------------
clear all; close all; clc;

% Load data for the problem
load('Data_prob2.mat');

%Loop over flights and itineraries to make path matrix delta with as 
%rows flights,and itineraries as columns. Is 1 when flight is in itinerary.
delta=zeros(num_flights,num_it); 
for f=1:num_flights
    fnum = flight_no(f); 
    for i=1:num_it
        leg1 = legs(i,1);
        leg2 = legs(i,2);
        % If flight leg part of itinerary, add itinerary demand and add to
        % Delta matrix as 1 
        if fnum==leg1 %|| fnum==leg2
            delta(f,i)=1;
        elseif fnum==leg2
            delta(f,1)=1; 
        end   
    end
end 

%_______________RPM________________________________________________________
%Decision variables t^0_1, t^0_2, ..., (t^1_1, t^1_2 ....)
numdv=num_it; 

%Objective function
obj=zeros(numdv,1);
for i=1:numdv
    obj(i) = it(i,3); %fare 
end

%Constraints (6)
C6=zeros(num_flights,numdv); 
for f=1:num_flights
    for i=1:numdv
        %-1 because of >= 
        C6(f,i)=-1 * delta(f,i); 
    end        
end
%Because constraint >= multiply by -1 
rhs6=delta*it(:,2)-capacity; 
rhs6 = rhs6*-1;
rhs=rhs6;
Aineq=C6; 

lb = zeros(numdv,1); 
ub = []; 
[x,fval,exitflag,output,lambda] = linprog(obj,Aineq,rhs,[],[],lb,[]); 
pi = lambda.ineqlin;
sigma  = - lambda.eqlin; 

%Constraints (7)
%C7=zeros(num_it,numdv);
%rhs7=zeros(num_it,1); 
%for i=1:num_it
  %  rhs7(i,1) = it(i,2); %demand
 %   C7(i,i)=1; 
%end
%Aineq=[C6;C7];
%rhs=[rhs6;rhs7]; 
