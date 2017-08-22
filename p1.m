% David House
% CS 542
% Assignment 3
% Problem 1

function outcome = problem1()

	count_1 = 0;
	count_2 = 0;
	count_3 = 0;
	count_4 = 0;
	for i = 1:10000
	    dataPoint = rand;

		% Classify Category: A
	    if (dataPoint <= 0.22)
	        count_1 = count_1 + 1;

		% Classify Category: B
	    elseif (dataPoint > 0.22 && dataPoint <= 0.5)
	        count_2 = count_2 + 1;

		% Classify Category: C
	    elseif (dataPoint > 0.5 && dataPoint <= 0.7)
	        count_3 = count_3 + 1;

		% Classify Category: D
	    else 
	        count_4 = count_4 + 1;
	    end
	end

	outcome = [ (count_1 / 10000), (count_2 / 10000), (count_3 / 10000), (count_4 / 10000) ];

	bar(outcome);
end
