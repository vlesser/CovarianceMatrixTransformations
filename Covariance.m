%% Covariance
% Description: Pulls the position and velocity covariance data from STK and
% reconstructs the covariance matrix at a specified time instance for a HPOP
% satellite which is already propagated. Examples for pulling single elements,
% multiple elements and elements over multiple time steps are commented out. 

% Instructions: Change the satellite path, timeString, covariance coordinate
% frame and covariance elements as needed. 

%% Inputs
% Existing STK application, root and satellite
app = actxGetRunningServer('STK12.application');
root = app.Personality2;
satellite = root.GetObjectFromPath('*/Satellite/Satellite1');
startTime = root.CurrentScenario.StartTime;
stopTime = root.CurrentScenario.StopTime;

% Time to pull covariance data
timeString = '01 Jun 2020 01:00:00.000'; % Example timeString

% Covariance folder and frame
covDP = satellite.DataProviders.GetDataPrvTimeVarFromPath('Axes Choose Axes/LVLH');
covDP.PreData = 'CentralBody/Earth Fixed';
covResults = covDP.Exec(startTime, stopTime, 60);

%This will calculate the matrix
q1 = cell2mat(covResults.DataSets.GetDataSetByName('q1').GetValues);
q2 = cell2mat(covResults.DataSets.GetDataSetByName('q2').GetValues);
q3 = cell2mat(covResults.DataSets.GetDataSetByName('q3').GetValues);
w = cell2mat(covResults.DataSets.GetDataSetByName('q4').GetValues);
QRotation = [w, q1, q2, q3]; 
%This uses the Matlab prebuilt function to compute the rotation matrix
qGetR(QRotation)



