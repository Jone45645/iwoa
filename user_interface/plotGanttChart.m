function plotGanttChart(bestSolution, problemDefinition, hGanttAxes)
    try
        tasks = problemDefinition.tasks;
        machines = problemDefinition.machines;
        solution = bestSolution.solution;

        % Initialize machine completion times
        machineCompletionTimes = zeros(1, length(machines));

        % Initialize plot data
        taskStartTimes = zeros(1, length(tasks));
        taskEndTimes = zeros(1, length(tasks));
        taskMachines = zeros(1, length(tasks));

        % Iterate through the solution to calculate start and end times
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

            % Update the start and end times for the task
            taskStartTimes(taskIdx) = startTime;
            taskEndTimes(taskIdx) = startTime + task.duration;
            taskMachines(taskIdx) = machineIdx;

            % Update the completion time for the machine
            machineCompletionTimes(machineIdx) = taskEndTimes(taskIdx);
        end

        % Plot the Gantt chart
        axes(hGanttAxes);
        hold off;
        for i = 1:length(tasks)
            rectangle('Position', [taskStartTimes(i), taskMachines(i) - 0.4, taskEndTimes(i) - taskStartTimes(i), 0.8], ...
                      'FaceColor', rand(1, 3), 'EdgeColor', 'black');
            text(taskStartTimes(i) + (taskEndTimes(i) - taskStartTimes(i)) / 2, taskMachines(i), num2str(tasks(i).id), ...
                 'HorizontalAlignment', 'center', 'VerticalAlignment', 'middle', 'Color', 'white');
        end
        xlabel('Time');
        ylabel('Machine');
        title('Gantt Chart');
    catch ME
        disp('Error plotting Gantt chart:');
        disp(getReport(ME, 'extended'));
    end
end
