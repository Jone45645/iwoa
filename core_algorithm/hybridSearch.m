function population = hybridSearch(population, bestSolution, iter, maxIterations, problemDefinition, param1, param2)
    % hybridSearch - Apply hybrid search strategy to update the population
    %
    % This function combines different search techniques to explore the solution space.
    % It includes local search and global search strategies to balance exploration and exploitation.
    %
    % Inputs:
    %   population - Current population of solutions
    %   bestSolution - The best solution found so far
    %   iter - Current iteration number
    %   maxIterations - Maximum number of iterations for the optimization loop
    %   problemDefinition - Struct containing the job shop scheduling problem definition
    %   param1 - Dynamically adjusted parameter 1
    %   param2 - Dynamically adjusted parameter 2
    %
    % Outputs:
    %   population - Updated population after applying the hybrid search strategy

    % Parameters for hybrid search
    localSearchProbability = 0.3 * param1; % Adjust probability with param1
    globalSearchProbability = 0.7 * param2; % Adjust probability with param2

    % Iterate through the population
    for i = 1:length(population)
        try
            if rand() < localSearchProbability
                % Apply local search strategy
                population(i).solution = localSearch(population(i).solution, problemDefinition);
            elseif rand() < globalSearchProbability
                % Apply global search strategy
                population(i).solution = globalSearch(population(i).solution, problemDefinition);
            end
            % Re-evaluate the fitness of the updated solution
            population(i).fitness = evaluateFitness(population(i).solution, problemDefinition);
        catch ME
            % Log the error message and stack trace
            disp('Error during hybrid search:');
            disp(getReport(ME, 'extended'));
        end
    end
end

function newSolution = localSearch(solution, problemDefinition)
    % localSearch - Apply local search strategy to a solution
    %
    % This function makes small adjustments to the solution to explore the local neighborhood.
    % It aims to improve the solution by making minor changes.
    %
    % Inputs:
    %   solution - Current solution
    %   problemDefinition - Struct containing the job shop scheduling problem definition
    %
    % Outputs:
    %   newSolution - Updated solution after applying local search

    % Example local search: Swap two random tasks
    newSolution = solution;
    numTasks = length(problemDefinition.tasks);
    if numTasks > 1
        swapIdx = randperm(numTasks, 2);
        temp = newSolution(swapIdx(1));
        newSolution(swapIdx(1)) = newSolution(swapIdx(2));
        newSolution(swapIdx(2)) = temp;
    end
end

function newSolution = globalSearch(solution, problemDefinition)
    % globalSearch - Apply global search strategy to a solution
    %
    % This function makes larger adjustments to the solution to explore new regions of the solution space.
    %
    % Inputs:
    %   solution - Current solution
    %   problemDefinition - Struct containing the job shop scheduling problem definition
    %
    % Outputs:
    %   newSolution - Updated solution after applying global search

    % Example global search: Shuffle a subset of tasks
    newSolution = solution;
    numTasks = length(problemDefinition.tasks);
    if numTasks > 1
        shuffleIdx = randperm(numTasks, ceil(numTasks / 2));
        newSolution(shuffleIdx) = newSolution(shuffleIdx(randperm(length(shuffleIdx))));
    end
end