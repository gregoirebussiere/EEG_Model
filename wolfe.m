%% Wolfe linear research

function [alphan,ok]=wolfe(par,x,y,D)

% y : objective function
% D : descent direction
% omega1 : 1st condition coefficient 
% omega2 : 2nd condition coefficient


   omega1 = 0.1;
   omega2 = 0.9;

   alphamin = 0.0;
   alphamax = inf;

 
   dltx = 0.0001;

% ---------------------------------
% Fletcher-Lemarechal algorithm
% ---------------------------------

   
   [F,G] = Oracle(par,x,y);
   

   % Initialisation

   alphan = 1;
   parn   = par;

   while ok == 0
      
        parp = parn;
        parn = par + (alphan*D);
        

        if norm(parn-parp) < dltx 
            ok = 2;
        end
        
        [Fn,Gn] = Oracle(parn,x,y);
        
      % Wolfe conditions
        
        C1 = norm(Fn) <= norm(F) - omega1 * alphan * (G'*F)' * D;
        C2 = (Gn'*Fn)' * D >= omega2 * (G'*F)' * D;

        if not(C1)
            alphamax = alphan;
            alphan = 0.5 * (alphamin + alphamax);
        else
            if C2
                ok = 1;
            else
                alphamin = alphan;
                if alphamax == inf
                    alphan = 2 * alphan;
                else
                    alphan = 0.5 * (alphamin + alphamax);
                end
            end    
        end


   end

end
