function fitness = evaluateFitness(solution, problemDefinition)
    try
        tasks = problemDefinition.tasks;
        machines = problemDefinition.machines;
        
        % Initialize machine completion times
        machineCompletionTimes = zeros(1, length(machines));
        
        % Iterate through the solution to calculate completion times
        for i = 1:length(solution)
            taskIdx = solution(i);
            task = tasks(taskIdx);

            % Ensure the machine index is within bounds
            if task.machine > length(machineCompletionTimes)
                error('Machine index exceeds the number of machines');
            end

            % Find the earliest time the task can be scheduled on its required machine
            machineIdx = task.machine;
            startTime = machineCompletionTimes(machineIdx);

            % Update the completion time for the machine
            machineCompletionTimes(machineIdx) = startTime + task.duration;
        end

        % The fitness is the maximum completion time across all machines
        fitness = max(machineCompletionTimes);
    catch ME
        % Log the error message and stack trace
        disp('Error evaluating fitness:');
        disp(getReport(ME, 'extended'));
        fitness = inf; % Return a large fitness value in case of error
    end
end
