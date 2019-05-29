function [alphan,ok]=wolfe(par,x,y,D)


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                          %
%   RECHERCHE LINEAIRE SUIVANT LES CONDITIONS DE WOLFE     %
%                                                          %
%                                                          %
%  Arguments en entree                                     %
%  -------------------                                     %
%    alpha  : valeur initiale du pas                       %
%    x      : valeur initiale des variables                %
%    D      : direction de descente                        %
%                                                          %
%                                                          %
%  Arguments en sortie                                     %
%  -------------------                                     %
%    alphan : valeur du pas apres recherche lineaire       %
%    ok     : indicateur de reussite de la recherche       %
%             = 1 : conditions de Wolfe verifiees          %
%             = 2 : indistinguabilite des iteres           %
%                                                          %
%                                                          %
%    omega1 : coefficient pour la 1-ere condition de Wolfe %
%    omega2 : coefficient pour la 2-eme condition de Wolfe %
%                                                          %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% -------------------------------------
% Coefficients de la recherche lineaire
% -------------------------------------

   omega1 = 0.1;
   omega2 = 0.9;

   alphamin = 0.0;
   alphamax = inf;

   ok = 0;
   dltx = 0.0001;

% ---------------------------------
% Algorithme de Fletcher-Lemarechal
% ---------------------------------

   % Appel de l'oracle au point initial
   
   [F,G] = Oracle(par,x,y);
   

   % Initialisation de l'algorithme

   alphan = 1;
   parn   = par;

   % Boucle de calcul du pas
   %
   % xn represente le point pour la valeur courante du pas,
   % xp represente le point pour la valeur precedente du pas.

   while ok == 0
      
        parp = parn;
        parn = par + (alphan*D);
        % Test d'indistinguabilite

        if norm(parn-parp) < dltx 
            ok = 2;
        end
        
        [Fn,Gn] = Oracle(parn,x,y);
        
      % Calcul des conditions de Wolfe
        
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
