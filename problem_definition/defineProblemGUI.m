function problemDefinition = defineProblemGUI(hNumTasks, hNumMachines)
    % defineProblemGUI - Define the Job Shop Scheduling Problem (JSP) using GUI inputs
    %
    % This function allows users to define the parameters of the JSP through a GUI.
    % It includes detailed problem definitions including tasks, machines, and constraints.
    %
    % Outputs:
    %   problemDefinition - Struct containing the job shop scheduling problem definition
    %
    % Example:
    %   problemDefinition = defineProblemGUI();

    try
        disp('Defining the problem...');

        % Check if handles are valid
        if ~ishandle(hNumTasks) || ~ishandle(hNumMachines)
            error('GUI handles are invalid or have been deleted.');
        end

        % Get the number of tasks and machines from the GUI
        numTasks = str2double(get(hNumTasks, 'String'));
        numMachines = str2double(get(hNumMachines, 'String'));

        % Initialize tasks and machines
        tasks = defineTasks(numTasks);
        machines = defineMachines(numMachines);

        % Define constraints (if any)
        constraints = defineConstraints();

        % Create the problem definition struct
        problemDefinition = struct('tasks', {tasks}, 'machines', {machines}, 'constraints', constraints);

        disp('Problem defined successfully.');
    catch ME
        % Log the error message and stack trace
        disp('Error defining the problem:');
        disp(getReport(ME, 'extended'));
        problemDefinition = struct(); % Return an empty struct in case of error
    end
end

function tasks = defineTasks(numTasks)
    % defineTasks - Define the tasks for the JSP using GUI inputs
    %
    % This function generates task definitions based on the number of tasks.
    %
    % Inputs:
    %   numTasks - Number of tasks to be defined
    %
    % Outputs:
    %   tasks - Array of structs containing task definitions

    tasks = struct('id', {}, 'machine', {}, 'duration', {});
    for i = 1:numTasks
        task.id = i;
        task.machine = randi([1, 5]); % Random machine assignment for simplicity
        task.duration = randi([1, 10]); % Random duration for simplicity
        tasks(i) = task;
    end
end

function machines = defineMachines(numMachines)
    % defineMachines - Define the machines for the JSP using GUI inputs
    %
    % This function generates machine definitions based on the number of machines.
    %
    % Inputs:
    %   numMachines - Number of machines to be defined
    %
    % Outputs:
    %   machines - Array of structs containing machine definitions

    machines = struct('id', {}, 'capacity', {});
    for i = 1:numMachines
        machine.id = i;
        machine.capacity = randi([1, 10]); % Random capacity for simplicity
        machines(i) = machine;
    end
end

function constraints = defineConstraints()
    % defineConstraints - Define the constraints for the JSP
    %
    % This function generates constraints for the JSP.
    %
    % Outputs:
    %   constraints - Struct containing constraints

    constraints = struct('type', {}, 'parameters', {});
    % Add constraint definitions here
end
