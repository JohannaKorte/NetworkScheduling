% ASSIGNMENT Ib:  Air Cargo Multi-commodity Flow
%
% TU Delft 2018
%
% Johanna Korte
% Carmen Velarde
%--------------------------------------------------------------------------
% Solve Separation problem: Add rows
%
% Check for constraint (7) of pax mix flow problem. 
% If not fulfilled --> add constraint to RPM
%--------------------------------------------------------------------------

function [Opt_row, v_addrow] = AddRows(dv, recap, num_it)
% Input:
%
% dv: Decision vbles resulting from RPM
% recap
% num_recap


% Value of decision vbles
t = dv(:,1);
% Index of the recapture matrix of each decision vble
index_r = dv(:,2);

k = 1;
Opt_row = 0;
for j=1:num_it
    
    % origin itinerary for of each dv
    itp = recap(index_r,1);    
    
    % Find all dv with originating itinerary = j
    p = find(itp==j);
    
if min(size(p))>0 % no dv with originating itinerary = j
    
   Dp = it(j,2);
    
   % Constraint ()    
   C7 = sum(t(p)) - Dp;

   if C7>0 % Does not fulfill constraint
       v_addrow(k) = j;
       k = k+1;
   end
   end

   if k==1
       Opt_row = 1;
   end
end

end






