function bestSolution = iwoaMain(problemDefinition, maxIterations, populationSize)
    % iwoaMain - Main function for the Improved Whale Optimization Algorithm (IWOA)
    %
    % This function runs the IWOA to solve the Job Shop Scheduling Problem (JSP).
    %
    % Inputs:
    %   problemDefinition - Struct containing the job shop scheduling problem definition
    %   maxIterations - Maximum number of iterations for the algorithm
    %   populationSize - Size of the population
    %
    % Outputs:
    %   bestSolution - Struct containing the best solution found

    try
        % Initialize population
        population = initPopulation(populationSize, problemDefinition);

        % Main loop
        for iter = 1:maxIterations
            disp(['Iteration: ', num2str(iter)]); % 添加调试信息

            % Evaluate fitness of each solution
            for i = 1:populationSize
                population(i).fitness = evaluateFitness(population(i).solution, problemDefinition);
            end

            % Sort population by fitness
            population = sortPopulationByFitness(population);

            % Update population using IWOA operators
            population = updatePopulation(population, iter, maxIterations, problemDefinition);

            % Save the best solution
            bestSolution = population(1);
        end

        disp('IWOA completed successfully.');
    catch ME
        disp('Error in IWOA main function:');
        disp(getReport(ME, 'extended'));
        bestSolution = struct(); % Return an empty struct in case of error
    end
end

function population = initPopulation(populationSize, problemDefinition)
    % initPopulation - Initialize the population for IWOA
    %
    % Inputs:
    %   populationSize - Size of the population
    %   problemDefinition - Struct containing the job shop scheduling problem definition
    %
    % Outputs:
    %   population - Array of structs containing the initial population

    numTasks = length(problemDefinition.tasks);
    population = struct('solution', {}, 'fitness', {});
    for i = 1:populationSize
        solution = randperm(numTasks); % Random permutation of tasks
        population(i).solution = solution;
        population(i).fitness = inf; % Initialize fitness to infinity
    end
end

function sortedPopulation = sortPopulationByFitness(population)
    % sortPopulationByFitness - Sort the population by fitness in ascending order
    %
    % Inputs:
    %   population - Array of structs containing the population
    %
    % Outputs:
    %   sortedPopulation - Sorted population by fitness

    [~, idx] = sort([population.fitness]);
    sortedPopulation = population(idx);
end

function updatedPopulation = updatePopulation(population, iter, maxIterations, problemDefinition)
    % updatePopulation - Update the population using IWOA operators
    %
    % This function applies IWOA operators to update the population.
    %
    % Inputs:
    %   population - Array of structs containing the current population
    %   iter - Current iteration number
    %   maxIterations - Maximum number of iterations
    %   problemDefinition - Struct containing the job shop scheduling problem definition
    %
    % Outputs:
    %   updatedPopulation - Updated population

    updatedPopulation = population; % Placeholder for actual update logic

    % Apply hybrid search strategies
    for i = 1:length(population)
        try
            % Apply local search
            updatedSolution = localSearch(population(i).solution, problemDefinition);
            population(i).solution = updatedSolution;

            % Apply global search
            updatedSolution = globalSearch(population(i).solution, problemDefinition);
            population(i).solution = updatedSolution;

            % Re-evaluate the fitness of the updated solution
            population(i).fitness = evaluateFitness(population(i).solution, problemDefinition);
        catch ME
            % Log the error message and stack trace
            disp('Error during hybrid search:');
            disp(getReport(ME, 'extended'));
        end
    end
end
