% David House
% CS 542
% Assignment 3
% Problem 3

% Produces random samples from 1D Gaussian mixture models.
function problem3()

	outcome = MCMC(@p3, @q, @generateSamples, 0, 10000);
	val = hist(outcome,20);
	val = val ./ 10000;
	bar(val);

end


function outcome = q(z, given)

	outcome = (1 / sqrt(pi*2))*exp3((-(z-given)^2)/2);

end


function outcome = p3(z)

	mx1 = 0.3*(1 / (0.2*sqrt(2*pi)))*exp3((-(z-(-1.5))^2)/(2*0.2));
	mx2 = 0.2*(1 / (1.5*sqrt(2*pi)))*exp3((-(z-(0))^2)/(2*1.5));
	mx3 = 0.5*(1 / (0.2*sqrt(2*pi)))*exp3((-(z-(0.1))^2)/(2*0.2));

	outcome = mx1+mx2+mx3;

end


function outcome = generateSamples(z)

	outcome = z + randn;

end
