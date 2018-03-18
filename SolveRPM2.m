function [dv, FVAL, pi, sigma] = solveRPM2(dv,recap_rate,delta,num_flights,...
                                           num_it,capacity,it, v_addcol, v_addrow)

% Inputs:
% dv :: Array of size numdvx2 with decision variables:
%       dv(:,1) = index  :: Location in recap_rate of the recapture itinerary
%       dv(:,2) = X      :: Value of the decision variable (Empty at input)

%__________________________________________________________________________


%TODO: also return index of variables in matrix!
    numdv=length(dv(:,1)); 
    % Add Columns:
    dv(numdv+1:numdv+length(v_addcol),1) = v_addcol;
    numdv=numdv+length(v_addcol);
    
    num_recap = length(recap_rate(:,1));
    p=recap_rate(:,1);
    r=recap_rate(:,2);
    b=recap_rate(:,3); 
    fare_p=recap_rate(:,4); 
    fare_r=recap_rate(:,5); 
    
    %Objective function
    obj=zeros(numdv,1);
    for i = 1:numdv
        j = dv(i,1);
        obj(i)=fare_p(j)-b(j)*fare_r(j); 
    end         
    
    
    % Constraints
    Aineq = zeros(num_flights,numdv);
    rhs   = zeros(num_flights,1);
    
    %Constraints (6)
    %TODO: Two inner loops can probably be made into one
%     C6=zeros(num_flights,numdv); 
%     for f=1:num_flights
%         for p6=1:num_it
%             for r6=1:num_it
%                 recap_index = find(r==r6 & p==p6); %Find right index for dv
%                 if isempty(recap_index)
%                     continue 
%                 else
%                     dv_index = find(dv(:,1)==recap_index);
%                     C6(dv_index)= C6(dv_index) -1* delta(f,p6); %-1 because >= constraint
%                 end     
%             end   
%         end   
%         
%         for r6=1:num_it
%             for p6=1:num_it
%                 recap_index = find(r==p6 & p==r6); 
%                 if isempty(recap_index)
%                     continue
%                 else
%                     dv_index = find(dv(:,1)==recap_index); 
%                     C6(dv_index)= C6(dv_index) -1 * -1*b(recap_index);  %-1 because >= constraint and in constraint      
%                 end  
%             end
%         end 
%            
%     end
%     disp('columns 6 added')
    
    %Because constraint >= multiply by -1 
%     rhs6=delta*it(:,2)-capacity;
%     rhs6 =rhs6*-1;

    [Aineq,rhs] = ConstraintC6(dv, recap_rate, it,capacity, delta,num_flights);

    %Constraints (7)
    Aineq7=buildC7(dv, recap_rate, num_it);
    rhs7= it(:,2);      
    % Add rows:        
    Aineq=[Aineq;Aineq7(v_addrow,:)];
    rhs = [rhs;rhs7(v_addrow)];
    
    lb = zeros(numdv,1); 
    ub = []; 
    [X,FVAL,exitflag,output,lambda] = linprog(obj,Aineq,rhs,[],[],lb,ub); 
    pi = lambda.ineqlin;
    sigma  = - lambda.eqlin; 
    if min(size(sigma))==0
    sigma=zeros(num_it,1);
    end
    dv(:,2) = X;

end 
