function Aineq_C7 = buildC7(dv, recap, num_it)



% Value of decision vbles
t = dv(:,1);
num_dv = length(t);

% Index of the recapture matrix of each decision vble
index_r = dv(:,2);

Aineq_C7 = zeros(num_dv,num_it);

for j=1:num_it
    
    % origin itinerary for of each dv
    itp = recap(index_r,1);    
    
    % Find all dv with originating itinerary = j
    p = find(itp==j);
    
  if min(size(p))>0 % no dv with originating itinerary = j
    
     Aineq_C7(j,p) = 1;    

  end

end


end

