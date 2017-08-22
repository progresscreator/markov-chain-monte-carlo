% David House
% CS 542
% Assignment 3
% Problem 2

function problem2()

	sectionA
	sectionB
	sectionC 
end


% Z = Burglary, Earthquake
function outcome = sectionA()

	val_xs = MCMC(@pa, @q, @dataPointgen, [1; 1], 10000);

	count1_EQ = 0;
	count2_BG = 0;
	for i = 1:10000
	    dataPoint = val_xs(:,i);
	    if (dataPoint(2,1) == 0)
	        count1_EQ = count1_EQ + 1;
	    end
	    if (dataPoint(1,1) == 1)
	        count2_BG = count2_BG + 1;
	    end
	end

	outcome = [count1_EQ / 10000, count2_BG / 10000];

	end

	function outcome = pA(z)

	bg = z(1,1);
	eq = z(2,1);

	if (eq == 1 && bg == 1)
	    outcome = 0.95;
	elseif (eq == 1 && bg == 0)
	    outcome = 0.29;
	elseif (eq == 0 && bg == 1)
	    outcome = 0.94;
	else
	    outcome = 0.001;
	end

end


% Z = [Burglary, Earthquake, Alarm, JohnCalls, MaryCalls]
function outcome = sectionB()

	val_xs = MCMC(@pb, @q, @dataPointmk_B, [0;0;0;1;1], 10000);
	counterB = 0;
	counterB3 = 0;

	for i = 1:10000
	    dataPoint = val_xs(1,i);
	    if (dataPoint == 0)
	        counterB3 = counterB3 + 1;
	    else
	        counterB = counterB + 1;
	    end
	end

	outcome = [counterB / 10000, counterB3 / 10000];

end


% Pr(B) * Pr(E) * Pr(A|B,E) * Pr(J|A) * Pr(M|A)
function outcome = pB(z)

	if (z(1,1) == 1)
	    outcome = 0.001;
	else
	    outcome = 0.999;
	end


	if (z(2,1) == 1)
	    outcome = outcome * 0.002;
	else
	    outcome = outcome * 0.998;
	end


	if (z(3,1) == 1)
	    if (z(1,1) == 1)
	        if (z(2,1) == 1)
	            outcome = outcome * 0.95;
	        else 
	            outcome = outcome * 0.94;
	        end
	    else
	        if (z(2,1) == 1)
	            outcome = outcome * 0.29;
	        else
	            outcome = outcome * 0.001;
	        end
	    end
	else
	    if (z(1,1) == 1)
	        if (z(2,1) == 1)
	            outcome = outcome * 0.05;
	        else 
	            outcome = outcome * 0.06;
	        end
	    else
	        if (z(2,1) == 1)
	            outcome = outcome * 0.71;
	        else
	            outcome = outcome * 0.999;
	        end
	    end
	end


	if (z(4,1) == 1)
	    if (z(3,1) == 1)
	        outcome = outcome * 0.9;
	    else
	        outcome = outcome * 0.05;
	    end
	else
	    if (z(3,1) == 1)
	        outcome = outcome * 0.1;
	    else
	        outcome = outcome * 0.95;
	    end
	end


	if (z(5,1) == 1)
	    if (z(3,1) == 1)
	        outcome = outcome * 0.7;
	    else
	        outcome = outcome * 0.01;
	    end
	else
	    if (z(3,1) == 1)
	        outcome = outcome * 0.3;
	    else
	        outcome = outcome * 0.99;
	    end
	end

end


function outcome = dataPointmk_B(z)

	elmnt = ceil(rand * 3);
	val = rand;

	if (val < 0.5)
	    z(elmnt,1) = 0;
	else
	    z(elmnt,1) = 1;
	end

	outcome = z;

end


% Z = [JohnCalls, MaryCalls]
function outcome = sectionC()

	val_xs = MCMC(@pb, @q, @dataPointgen, [0;0;0;0;0], 10000);
	counter = 0;
	for i = 1:10000
	    dataPoint = val_xs(:,i);
	    if (dataPoint(4,1) == 1 && dataPoint(5,1) == 1)
	        counter = counter + 1;
	    end
	end

	outcome = counter / 10000;

end


% Change Random Z
function outcome = dataPointgen(z)

	val = rand;
	elmnt = ceil(rand * length(z));

	if (val > 0.5)
	    z(elmnt,1) = 1;
	else
	    z(elmnt,1) = 0;
	end

	outcome = z;

end


function outcome = q(z, input)

	outcome = 0.5;

end
