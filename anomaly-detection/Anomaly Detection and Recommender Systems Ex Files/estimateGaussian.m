function [mu sigma2] = estimateGaussian(X)
%ESTIMATEGAUSSIAN This function estimates the parameters of a 
%Gaussian distribution using the data in X
%   [mu sigma2] = estimateGaussian(X), 
%   The input X is the dataset with each n-dimensional data point in one row
%   The output is an n-dimensional vector mu, the mean of the data set
%   and the variances sigma^2, an n x 1 vector
% 

% Useful variables
[m, n] = size(X); %307x2

% You should return these values correctly
mu = zeros(n, 1);
sigma2 = zeros(n, 1);

% ====================== YOUR CODE HERE ======================
% Instructions: Compute the mean of the data and the variances
%               In particular, mu(i) should contain the mean of
%               the data for the i-th feature and sigma2(i)
%               should contain variance of the i-th feature.
%

sum = 0;

for i = 1:n
  for k = 1:m
    sum = sum + X(k, i);
  endfor
  mu(i) = sum / m;
  sum = 0;
endfor

for i = 1:n
  for k = 1:m
    diff = X(k, i) - mu(i);
    diff2 = diff^2;
    sum = sum + diff2;
  endfor
  sigma2(i) = sum / m;
  sum = 0;
endfor


% =============================================================


end
