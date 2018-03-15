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

function [Opt_row, v_addrow] = AddRows(dv, it, recap_rate, num_it)
% Input:
%
% dv: Decision vbles resulting from RPM
% recap
% it
% num_recap


Aineq_C7 = buildC7(dv, recap_rate, num_it);
Dp = it(:,2);

C7 = Aineq_C7*dv(:,2)-Dp;

% Check constraint (7)
j = find(C7>0); % Does not fulfill constraint

if min(size(j))>0
    Opt_row  = 0;
    v_addrow = j;
else
    Opt_row  = 1;
    v_addrow = [];
   
end

end






