function initIWOA()
    % initIWOA - Initialize the Improved Whale Optimization Algorithm (IWOA)
    %
    % This function sets up the initial configuration for the IWOA algorithm
    % and calls the main function to run the optimization.
    %
    % Example:
    %   initIWOA();

    try
        disp('Initializing IWOA...');

        % Define the problem using the problem definition module
        numTasks = 10; % 设置任务数量
        numMachines = 5; % 设置机器数量
        problemDefinition = defineProblem(numTasks, numMachines);

        % Define algorithm parameters
        maxIterations = 1000;
        populationSize = 30;

        % Run the main IWOA function
        bestSolution = iwoaMain(problemDefinition, maxIterations, populationSize);

        % Display the best solution found
        disp('Best solution found:');
        disp(bestSolution);
    catch ME
        % Log the error message and stack trace
        disp('Error initializing IWOA:');
        disp(getReport(ME, 'extended'));
    end
end