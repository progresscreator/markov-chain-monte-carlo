% David House
% CS 542
% Assignment 3
% Problem 4

% Produces random samples from a 1D gamma distribution.
function problem4()

	outcome = MCMC(@p, @q, @generateSamples, 0, 10000);
	val = hist(outcome,20);
	val = val ./ 10000;
	bar(val);

end


function outcome = p(z)

	outcome = gammaMaker(3,2,z);

end


function outcome = q(z, given)

	if (z == 0)
	    outcome = normcdf(0, given, 1);
	else
	    outcome = (1 / sqrt(2*pi))*exp((-(z-given)^2)/2);
	end

end

function outcome = generateSamples(z)

	outcome = z + randn;
	if (outcome < 0)
	    outcome = 0;
	end

end


function outcome = gammaMaker(a1, b2, c)

	outcome = (b2^a1)*c^(a1-1)*exp(-b2*c)/gamma(a1);

end
