function generatePerformanceReport()
    % generatePerformanceReport - Generate and display the performance evaluation report
    %
    % This function loads the performance evaluation report from the data file
    % and displays it in a new window.
    %
    % Example:
    %   generatePerformanceReport();

    try
        % Load the performance report from the data file
        performanceReport = loadData('performanceReport.mat');

        % Create a new figure for the performance report
        hFig = figure('Name', 'Performance Evaluation Report', 'NumberTitle', 'off', 'Position', [200, 200, 600, 400]);

        % Display the performance report in a text box
        reportText = sprintf('Fitness: %f\nMakespan: %f\nMachine Utilization: %s\nComputation Time: %f seconds', ...
                             performanceReport.fitness, performanceReport.makespan, ...
                             mat2str(performanceReport.machineUtilization), performanceReport.computationTime);

        uicontrol('Style', 'text', 'Position', [20, 20, 560, 360], 'String', reportText, 'HorizontalAlignment', 'left');

    catch ME
        % Log the error message and stack trace
        disp('Error generating performance report:');
        disp(getReport(ME, 'extended'));
    end
end