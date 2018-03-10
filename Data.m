% ASSIGNMENT Ia:  Air Cargo Multi-commodity Flow
%
% TU Delft 2018
%
% Johanna Korte
% Carmen Velarde
%--------------------------------------------------------------------------
% DATA
%--------------------------------------------------------------------------
clear all; close all; clc;

% Note: All arrays are writen in columns.


% Load data from Excel
[NUM,TXT,RAW] = xlsread('Input_AE4424_Ass1P1.xlsx','Arcs','A2:E31');
[NUM2,TXT2,RAW2] = xlsread('Input_AE4424_Ass1P1.xlsx','Commodities','A2:D41');

% Nodes - Airports
N = {'ANC' 'LAX' 'CVG' 'JFK' 'EMA' 'BRU' 'LEJ' 'LOS' 'BAH' 'DXB' 'DEL' 'SIN' 'BKK' 'HKG' 'PVG' 'ICN'};
n = length(N);
% Arcs
A = TXT;
nA = length(A);
% Cost
C = NUM(:,4);
% Capacity
u= NUM(:,5);
% Commodity
Karc = TXT2;
nK = length(Karc);
d =  NUM2(:,4);


% Assign node number to arcs:
Oa = zeros(nA,1); 
Da = zeros(nA,1);

for i=1:nA
    
    % Origin
    Oa(i) = find(strcmp(N, A{i,1}));
    % Destination
    Da(i) = find(strcmp(N, A{i,2}));
end

  Network = graph(Oa,Da,C,N);

 
% Assign node number to Commodity:
Ok = zeros(nK,1); 
Dk = zeros(nK,1);

for i=1:nK
    
    % Origin
    Ok(i) = find(strcmp(N, Karc{i,1}));
    % Destination
    Dk(i) = find(strcmp(N, Karc{i,2}));
    
end

    
  save('Data')
    
