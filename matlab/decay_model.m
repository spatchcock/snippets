% Load whitespace delimited data
data = load('decay_data.m')

% Assign data series from loaded data
time = data(1,:);
conc = data(2,:);

% Derive linear (i.e. 1st order polynomial) regression parameters using
% logged y-series
regression = polyfit(time,log(conc),1)

% Establish a model distribution for comparing with data
x_series = 0:0.01:20;
y_series = exp(regression(2)).*exp((regression(1).*x_series))

plot(time,conc,'+',x_series,y_series)