% David House
% CS 542
% Assignment 3
% Markov Chain Monte Carlo Implementation

function outcome = MCMC(p, q, g_samples, z_vec, total_samples)

	% Take the first 100 samples, per TF's instruction
	removeTotal = 100;

	% Init Vars
	total_elements = length(z_vec);
	z_out = zeros(total_elements, total_samples);

	for i = 1:(total_samples + removeTotal)
    
	  u = rand;

	  % Compute Z*
   	  zS = g_samples(z_vec);

   	  top_val = p(zS)*q(z_vec, zS);
   	  unter_val = p(z_vec)*q(zS, z_vec);
    
          % Compute A
   	  A_x = min(1, top_val/unter_val);

	  if (A_x > u)
	    z_out(:, i) = zS;
	    z_vec = zS;
	  else
            z_out(:,i) = z_vec;
    	  end
	end

	outcome = z_out;

end
