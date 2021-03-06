%% Wolfe linear research

function [alphan,ok]=wolfe(par,x,y,D)

% y : objective function
% D : descent direction
% omega1 : 1st condition coefficient 
% omega2 : 2nd condition coefficient


   omega1 = 0.01;
   omega2 = 0.99;

   alphamin = 0.0;
   alphamax = inf;

 
   dltx = 0.0001;

% ---------------------------------
% Fletcher-Lemarechal algorithm
% ---------------------------------

   
   [F,J] = Oracle(par,x,y,1);
   

   % Initialisation

   alphan = 1;
   parn   = par;
   ok = 0;

   while ok == 0
      
        parp = parn;
        parn = par + (alphan*D');
        

        if norm(parn-parp) < dltx 
            ok = 2;
        end
        
        [Fn,Jn] = Oracle(parn,x,y,1);
        
      % Wolfe conditions
        
        C1 = norm(Fn) <= norm(F) - omega1 * alphan * (J'*F)' * D;
        C2 = (Jn'*Fn)' * D >= omega2 * (J'*F)' * D;

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
