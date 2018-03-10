% ASSIGNMENT Ia:  Air Cargo Multi-commodity Flow
%
% TU Delft 2018
%
% Johanna Korte
% Carmen Velarde
%--------------------------------------------------------------------------
% Column Generation Algorithm
%--------------------------------------------------------------------------
clear all; close all; clc;

% Load data for the problem
load('Data.mat')

% Load data for validation
% load('test.mat')

% A. Initial set of columns for RMP:  shortest path algorithm
%--------------------------------------------------------------------------

Set1 = zeros(nA,nK);
Ap = zeros(nA,nK);
Kp = zeros(nK,nK);

% Path structure:
% K(k).P(p).path =[];
% p is the path counter
% k is commodity counter
% path array containing the nodes in order of the path

p = 1; 

for i = 1:nK
    
K(i).P(p).path = shortestpath(Network,Ok(i),Dk(i));

%    % Set1 is the initial set of columns.
%    % The rows correspond to each arc, the columns to the path of each
%    % commodity. The elements are the quantities. 
%    % ( See tableaux path formulation )
   for j=1:length(K(i).P(p).path)-1
       
       ni = K(i).P(p).path(j);
       nj = K(i).P(p).path(j+1); 
       
   i_arc = find(Oa==ni & Da==nj);
       
   Set1(i_arc,i) = d(i);
   
   % path arc matrix: 
   Ap(i_arc,i) = 1;
   
   end
   
   % path commodity matrix:
   Kp(i,i) = 1;

end

% 1. Compute slack variables:
%--------------------------------------------------------------------------
stemp = sum(Set1')'-u;
s = max(0,stemp);
ns = length(find(s>0));

figure
map = plot(Network,'Layout','force','EdgeLabel',Network.Edges.Weight);
highlight(map, K(1).P(p).path,'EdgeColor','red')

opt   = 0;
opt=0;

Maxit = 100;
Set = Set1;
it = 1;

fval_dec=1;
fvalold = 9999999;
while fval_dec == 1 && it < Maxit

% B. Solve RPM
%--------------------------------------------------------------------------
[f, fval, pi, sigma] = solveRPM(u,C,nK,nA,d,Set,Kp,Ap,s);

% % Check stop condition
% opt_cond = Ap'*(C+pi)-Kp'*(sigma./d);
% n_opt=length(find(opt_cond>=0));
% 
% nP = length(Set(1,:)); % number of paths
% if n_opt==nP
%     opt=1;
% end


% C. Modify costs
%--------------------------------------------------------------------------

cost = C-pi;
[K, Set, Ap, Kp] = GenerateSet(Oa, Da, nA, Ok, Dk, nK, K, Set, cost, sigma, d);

if fval >= fvalold
fval_dec= 0;
end

fvalold=fval;
it=it+1;
end


