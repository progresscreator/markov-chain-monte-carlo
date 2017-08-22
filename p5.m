% David House
% CS 542 Machine Learning
% Assignment 3
% Problem 5

% Application of MCMC:
function problem5()

	sectionA
	sectionB
	sectionC
end


% A.)
function outcome = sectionA()

values = MCMC(@p, @qA, @sampleGen, [1;1;1;1;1], 10000);

	counterX4 = 0;
	counterX5 = 0;
	for i = 1:10000
	    dataPoints = values(:,i);
	    counterX4 = counterX4 + dataPoints(4,1);
	    counterX5 = counterX5 + dataPoints(5,1);
	end

	outcome = [counterX4/10000, counterX5/10000];

end


% B.)
function outcome = sectionB()

	values = MCMC(@p,@qB,@sampleGen2, [1;1;0.75;1;1], 10000);
	counterX4 = 0;
	counterX5 = 0;
	for i = 1:10000
	    dataPoints = values(:,i);
	    counterX4 = counterX4 + dataPoints(4,1);
	    counterX5 = counterX5 + dataPoints(5,1);
	end
	outcome = [counterX4/10000, counterX5/10000];

end


% C.)
function outcome = sectionC()

	values = MCMC(@p,@qC,@sampleGen3, [0.8;1;0.75;1;1], 10000);
	counterX4 = 0;
	counterX5 = 0;
	for i = 1:10000
	    dataPoints = values(:,i);
	    counterX4 = counterX4 + dataPoints(4,1);
	    counterX5 = counterX5 + dataPoints(5,1);
	end
	outcome = [counterX4/10000, counterX5/10000];

end


% P(Z)
function outcome = p(z)

	x1 = 0.6*gaussianMaker(z(1,1),2,0.5) + 0.4*gaussianMaker(z(1,1),2,1.5);
	x2 = gammaMaker(3, 2, z(2,1));
	x3 = gaussianMaker(z(3,1),0.45,z(1,1));
	x4 = gaussianMaker(z(4,1),0.8,0.4*z(1,1)+0.6*z(2,1));
	x5 = gaussianMaker(z(5,1),0.5,0.2*z(3,1)+z(4,1));

	outcome = x1*x2*x3*x4*x5;

end


function outcome = qA(z,input)

	x1 = gaussianMaker(z(1,1)-input(1,1),1,0);
	x3 = gaussianMaker(z(3,1)-input(3,1),1,0);
	x4 = gaussianMaker(z(4,1)-input(4,1),1,0);
	x5 = gaussianMaker(z(5,1)-input(5,1),1,0);

	if (z(2,1) == 0)
	    x2 = normcdf(0, input(2,1), 1);
	else
	    x2 = gaussianMaker(z(2,1)-input(2,1),1,0);
	end

	outcome = x1*x2*x3*x4*x5;

end


function outcome = qB(z,input)

	x1 = gaussianMaker(z(1,1)-input(1,1),1,0);
	x4 = gaussianMaker(z(4,1)-input(4,1),1,0);
	x5 = gaussianMaker(z(5,1)-input(5,1),1,0);

	if (z(2,1) == 0)
	    x2 = normcdf(0, input(2,1), 1);
	else
	    x2 = gaussianMaker(z(2,1)-input(2,1),1,0);
	end

	outcome = x1*x2*x4*x5;

end


function outcome = qC(z,input)

	x4 = gaussianMaker(z(4,1)-input(4,1),1,0);
	x5 = gaussianMaker(z(5,1)-input(5,1),1,0);

	outcome = x4*x5;

end


function outcome = sampleGen(z)

	a(1,1) = z(1,1) + randn;
	a(2,1) = z(2,1) + randn;
	a(3,1) = z(3,1) + randn;
	a(4,1) = z(4,1) + randn;
	a(5,1) = z(5,1) + randn;

	if (a(2,1) < 0)
	    a(2,1) = 0;
	end

	outcome = a;

end


function outcome = sampleGen2(z)

	z(1,1) = z(1,1) + randn;
	z(2,1) = z(2,1) + randn;
	z(4,1) = z(4,1) + randn;
	z(5,1) = z(5,1) + randn;

	if (z(2,1) < 0)
	    z(2,1) = 0;
	end

	outcome = z;

end


function outcome = sampleGen3(z)

	z(4,1) = z(4,1) + randn;
	z(5,1) = z(5,1) + randn;

	outcome = z;

end


function outcome = gaussianMaker(x, sig, u)

	outcome = (1 / sqrt(2*pi*sig))*exp((-(x-u)^2)/(2*sig));

end


function outcome = gammaMaker(a1, b2, c)

	outcome = (b2^a1)*c^(a1-1)*exp(-b2*c)/gamma(a1);

end

