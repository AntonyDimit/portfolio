% Step 1: Define the fuzzy inference system (FIS)
%fis = newfis('Name', 'ValveRotationFIS');

% Step 1: Define the fuzzy inference system (FIS)
fis = newfis('ValveRotationFIS', 'mamdani', 'min', 'max', 'centroid');

% Step 2: Define input variables (Temperature and Pressure)
% Temperature: range from 400°C to 700°C
fis = addInput(fis, [400 700], 'Name', 'Temperature');

% Membership functions for Temperature
fis = addMF(fis, 'Temperature', 'trapmf', [400 400 500 600], 'Name', 'Low');
fis = addMF(fis, 'Temperature', 'trimf', [500 600 700], 'Name', 'Medium');
fis = addMF(fis, 'Temperature', 'trapmf', [600 700 700 700], 'Name', 'High');

% Pressure: range from 500 psig to 1000 psig
fis = addInput(fis, [500 1000], 'Name', 'Pressure');

% Membership functions for Pressure
fis = addMF(fis, 'Pressure', 'trapmf', [500 500 600 700], 'Name', 'Low');
fis = addMF(fis, 'Pressure', 'trimf', [600 700 800], 'Name', 'Medium');
fis = addMF(fis, 'Pressure', 'trapmf', [800 900 1000 1000], 'Name', 'High');

% Step 3: Define output variable (Valve Angle)
% Valve Angle: range from -90 to 90 degrees
fis = addOutput(fis, [-90 90], 'Name', 'ValveAngle');

% Membership functions for Valve Angle
fis = addMF(fis, 'ValveAngle', 'trapmf', [-90 -90 -60 -30], 'Name', 'Closed');
fis = addMF(fis, 'ValveAngle', 'trimf', [-60 0 60], 'Name', 'HalfOpen');
fis = addMF(fis, 'ValveAngle', 'trapmf', [30 60 90 90], 'Name', 'Open');

% Step 4: Define the fuzzy rules

ruleList = [
    "If Temperature is Low and Pressure is Low then ValveAngle is Closed";
    "If Temperature is Low and Pressure is Medium then ValveAngle is HalfOpen";
    "If Temperature is Low and Pressure is High then ValveAngle is Open";
    "If Temperature is Medium and Pressure is Low then ValveAngle is HalfOpen";
    "If Temperature is Medium and Pressure is Medium then ValveAngle is HalfOpen";
    "If Temperature is Medium and Pressure is High then ValveAngle is Open";
    "If Temperature is High and Pressure is Low then ValveAngle is Open";
    "If Temperature is High and Pressure is Medium then ValveAngle is Open";
    "If Temperature is High and Pressure is High then ValveAngle is Open";
];

% Add rules to FIS
fis = addRule(fis, ruleList);

% Step 5: Test the FIS

% Define input values
temperature = 550; % Celsius
pressure = 750; % psig

% Evaluate the system
output = evalfis([temperature pressure], fis);

% Display the result
fprintf('For Temperature = %.2f°C and Pressure = %.2f psig, the Valve Angle is %.2f degrees\n', ...
        temperature, pressure, output);
