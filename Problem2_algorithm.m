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

% A. Initial set of columns for RMP:  shortest path algorithm
%--------------------------------------------------------------------------

RMP_set = zeros(num_arcs_unique,num_itineraries);
flight_p = zeros(num_arcs_unique,num_itineraries);
itinerary_p = zeros(num_itineraries,num_itineraries);

% Path structure:
% K(k).P(p).path =[];
% p is the path counter
% k is commodity counter
% path array containing the nodes in order of the path

p = 1; 

for i = 1:num_itineraries  
K(i).P(p).path = shortestpath(Network,O_it(i),D_it(i));

%    % Set1 is the initial set of columns.
%    % The rows correspond to each arc, the columns to the path of each
%    % commodity. The elements are the quantities. 
%    % ( See tableaux path formulation )
   for j=1:length(K(i).P(p).path)-1
       
       ni = K(i).P(p).path(j);
       nj = K(i).P(p).path(j+1); 
       
   i_arc = find(O_arc==ni & D_arc==nj);
       
   RMP_set(i_arc,i) = it_demand(i);
   
   % path arc matrix: 
   flight_p(i_arc,i) = 1;
   
   end
   
   % path commodity matrix:
   itinerary_p(i,i) = 1;

end

% 1. Compute slack variables:
%--------------------------------------------------------------------------
s_temp = sum(RMP_set')'-capacity;
s = max(0,s_temp);

figure
map = plot(Network,'Layout','force','EdgeLabel',Network.Edges.Weight);
highlight(map, K(1).P(p).path,'EdgeColor','red')


% B. Solve RPM
%--------------------------------------------------------------------------
%[f, fval, pi, sigma] = solveRPM(u,C,nK,nA,d,Set,Kp,Ap,s);
