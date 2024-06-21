function initGUI()
    % initGUI - Initialize the graphical user interface (GUI) for the Job Shop Scheduling Problem (JSP) solver
    %
    % This function creates and initializes the GUI components for defining and solving the JSP.
    % Example:
    %   initGUI();

    try
        % Create the main figure window
        hFig = figure('Name', 'JSP Solver', 'NumberTitle', 'off', 'Position', [100, 100, 800, 600]);

        % Create UI controls for input parameters
        uicontrol('Style', 'text', 'Position', [20, 550, 100, 20], 'String', 'Number of Tasks:');
        hNumTasks = uicontrol('Style', 'edit', 'Position', [130, 550, 100, 20], 'String', '10');

        uicontrol('Style', 'text', 'Position', [20, 520, 100, 20], 'String', 'Number of Machines:');
        hNumMachines = uicontrol('Style', 'edit', 'Position', [130, 520, 100, 20], 'String', '5');

        uicontrol('Style', 'text', 'Position', [20, 490, 100, 20], 'String', 'Max Iterations:');
        hMaxIterations = uicontrol('Style', 'edit', 'Position', [130, 490, 100, 20], 'String', '100');

        uicontrol('Style', 'text', 'Position', [20, 460, 100, 20], 'String', 'Population Size:');
        hPopulationSize = uicontrol('Style', 'edit', 'Position', [130, 460, 100, 20], 'String', '50');

        % Create an axes for the Gantt chart
        hGanttAxes = axes('Units', 'pixels', 'Position', [250, 250, 500, 300]);

        % Create a button to start the optimization
        uicontrol('Style', 'pushbutton', 'Position', [20, 420, 210, 30], 'String', 'Start Optimization', ...
                  'Callback', @(~, ~) startOptimization(hNumTasks, hNumMachines, hMaxIterations, hPopulationSize, hGanttAxes));

        disp('GUI initialized successfully.');
    catch ME
        disp('Error initializing GUI:');
        disp(getReport(ME, 'extended'));
    end
end

function startOptimization(hNumTasks, hNumMachines, hMaxIterations, hPopulationSize, hGanttAxes)
    % startOptimization - Start the optimization process for the JSP solver
    %
    % This function retrieves the input parameters from the GUI, defines the problem,
    % runs the IWOA algorithm, and displays the results.
    %
    % Inputs:
    %   hNumTasks - Handle to the number of tasks input field
    %   hNumMachines - Handle to the number of machines input field
    %   hMaxIterations - Handle to the maximum iterations input field
    %   hPopulationSize - Handle to the population size input field
    %   hGanttAxes - Handle to the axes for plotting the Gantt chart

    try
        % Retrieve input parameters from the GUI
        numTasks = str2double(get(hNumTasks, 'String'));
        numMachines = str2double(get(hNumMachines, 'String'));
        maxIterations = str2double(get(hMaxIterations, 'String'));
        populationSize = str2double(get(hPopulationSize, 'String'));

        % Validate inputs
        if isnan(numTasks) || isnan(numMachines) || isnan(maxIterations) || isnan(populationSize)
            error('All input fields must be numeric values.');
        end

        % Define the problem using the inputs
        problemDefinition = defineProblemGUI(hNumTasks, hNumMachines);

        % Validate problem definition
        if isempty(fieldnames(problemDefinition))
            error('Problem definition is empty.');
        end

        % Run the main IWOA function
        bestSolution = iwoaMain(problemDefinition, maxIterations, populationSize);

        % Display the best solution found
        disp('Best solution found:');
        disp(bestSolution);

        % Plot the Gantt chart for the best solution
        plotGanttChart(bestSolution, problemDefinition, hGanttAxes);
    catch ME
        disp('Error starting optimization:');
        disp(getReport(ME, 'extended'));
    end
end
