function [dv, FVAL, pi, sigma] = solveRPM2(dv,recap_rate,delta,num_flights,capacity,it, v_addrow,v_addcol)

% Inputs:
% dv :: Structure of size numdv with decision variables:
%       dv.t = X :: Value of the decision variable (Empty at input)
%       dv.i     :: Location in recap_rate of the recapture itinerary

%__________________________________________________________________________




%TODO: also return index of variables in matrix!
    numdv=length(dv); 
    % Add Columns:
    dv(numdv+1:numdv+lengtht(v_addcol).i) = v_addcol;
    
    p=recap_rate(:,1);
    r=recap_rate(:,2);
    b=recap_rate(:,3); 
    fare_p=recap_rate(:,4); 
    fare_r=recap_rate(:,5); 
    
    %Objective function
    obj=zeros(numdv,1);
    for i = dv.i
        obj(i)=fare_p(i)-b(i)*fare_r(i); 
    end         
    
    %Constraints (6)
    %TODO: Two inner loops can probably be made into one
    C6=zeros(num_flights,numdv); 
    for f=1:num_flights
        for p6=1:num_it
            for r6=1:num_it
                recap_index = find(r==r6 & p==p6); %Find right index for dv 
                dv_index = find(dv.i==recap_index); 
                if isempty(dv_index)
                    continue
                else 
                    C6(dv_index)= -1* delta(f,p6); %-1 because >= constraint
                end  
            end   
        end   
        
        for r6=1:num_it
            for p6=1:num_it
                recap_index = find(r==p6 & p==r6); 
                dv_index = find(dv.i==recap_index); 
                if isempty(dv_index)
                    continue 
                else 
                    C6(dv_index)= -1 * -1*b(recap_index);  %-1 because >= constraint and in constraint
                end        
            end
        end 
           
    end
    %Because constraint >= multiply by -1 
    rhs6=delta*it(:,2)-capacity; %Not sure if right?!  --> right ;)
    rhs6 =rhs6*-1;
    rhs=rhs6;
    Aineq=C6; 
   
    %Constraints (7)
    Aineq7=buildC7(dv);
    rhs7= it(:,2);  
    
    % Add rows:        
    Aineq=[Aineq;Aineq7(v_addrow,:)];
    rhs = [rhs;rhs7(v_addrow)];
    
    lb = zeros(numdv,1); 
    ub = []; 
    [X,FVAL,exitflag,output,lambda] = linprog(obj,Aineq,rhs,[],[],lb,ub); 
    pi = lambda.ineqlin;
    sigma  = - lambda.eqlin; 
    dv.t = X;
    %TODO also return index of variables in matrix!
end 
