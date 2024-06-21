function data = loadData(filename)
    % loadData - Load data from a MATLAB data file
    %
    % This function loads data from a specified file.
    %
    % Inputs:
    %   filename - Name of the file to load the data from (string)
    %
    % Outputs:
    %   data - Loaded data (any MATLAB data type)
    %
    % Example:
    %   problemDefinition = loadData('problemDefinition.mat');

    try
        loadedData = load(filename, 'data');
        data = loadedData.data;
        disp(['Data loaded successfully from ', filename]);
    catch ME
        % Log the error message and stack trace
        disp(['Error loading data from ', filename, ':']);
        disp(getReport(ME, 'extended'));
        data = []; % Return an empty array in case of error
    end
end