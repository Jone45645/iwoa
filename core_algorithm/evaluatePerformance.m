function performanceReport = evaluatePerformance(problemDefinition, bestSolution, computationTime)
    try
        % Calculate the fitness of the best solution
        fitness = evaluateFitness(bestSolution.solution, problemDefinition);

        % Calculate machine utilization
        machineUtilization = calculateMachineUtilization(problemDefinition, bestSolution.solution);

        % Generate the performance report
        performanceReport = struct();
        performanceReport.fitness = fitness;
        performanceReport.computationTime = computationTime;
        performanceReport.machineUtilization = machineUtilization;
    catch ME
        % Log the error message and stack trace
        disp('Error evaluating performance:');
        disp(getReport(ME, 'extended'));
        performanceReport = struct();
    end
end

function machineUtilization = calculateMachineUtilization(problemDefinition, solution)
    tasks = problemDefinition.tasks;
    machines = problemDefinition.machines;

    machineUtilization = zeros(1, length(machines));

    for i = 1:length(solution)
        taskIdx = solution(i);
        task = tasks(taskIdx);

        % Ensure the machine index is within bounds
        if task.machine > length(machineUtilization)
            error('Machine index exceeds the number of machines');
        end

        machineUtilization(task.machine) = machineUtilization(task.machine) + task.duration;
    end
end
