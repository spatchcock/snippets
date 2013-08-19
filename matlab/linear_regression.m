% Define data series
Light=[20 20 20 20 21 24 44 60 90 94 101];
rmax=[1.73 1.65 2.02 1.89 2.61 1.36 2.37 2.08 2.69 2.32 3.67];

% Display histogram of one series
% hist(Light);

% Plot distribution as a scatterplot
plot(Light,rmax,'+')

% Fit a 1st degree polynomial to the distribution
% Returns coefficients of polynomial terms
C=polyfit(Light,rmax,1)

% Build distribution representing fitted 1st first order polynomial
xvals=0:120;
yhat=polyval(C,xvals);
 
% Plot both distributions - data and model
plot(Light,rmax,'+',xvals,yhat)