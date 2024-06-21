function saveData(filename, data)
    % saveData - Save data to a MATLAB data file
    %
    % This function saves the given data to a specified file.
    %
    % Inputs:
    %   filename - Name of the file to save the data to (string)
    %   data - Data to be saved (any MATLAB data type)
    %
    % Example:
    %   saveData('problemDefinition.mat', problemDefinition);

    try
        save(filename, 'data');
        disp(['Data saved successfully to ', filename]);
    catch ME
        % Log the error message and stack trace
        disp(['Error saving data to ', filename, ':']);
        disp(getReport(ME, 'extended'));
    end
end