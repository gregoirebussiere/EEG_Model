function [par0] = LM(par0,x,y)

[F,J] = Oracle(par0,x,y,1);
lambda = 10;
best = 0.5*norm(F);

for i=1:2
    temp = best + 1;
    
    while temp > best
        
            
        lambda_temp = lambda/10;
        delta_temp = (J'*J + lambda_temp * diag(diag(J'*J))) \ (J'*F);
        par_temp = par0 + delta_temp;
        temp = norm(Oracle(par_temp,x,y,2));

        
        if temp<best
            par0 = par_temp; 
            lambda = lambda_temp;
            best = temp;
           
        
        else
            delta_temp = (J'*J - lambda * diag(diag(J'*J))) \ (J'*F);
            par_temp = par0 + delta_temp;
            temp = norm(Oracle(par_temp,x,y,2));

            if temp<best
               par0 = par_temp;
               best = temp;
            else
               lambda = lambda * 10;
            end
        end
       
            
        
        
    end
    [F,J] = Oracle(par0,x,y,1);
end
end