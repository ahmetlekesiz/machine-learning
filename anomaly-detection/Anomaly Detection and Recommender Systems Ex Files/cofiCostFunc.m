function [J, grad] = cofiCostFunc(params, Y, R, num_users, num_movies, ...
                                  num_features, lambda)
%COFICOSTFUNC Collaborative filtering cost function
%   [J, grad] = COFICOSTFUNC(params, Y, R, num_users, num_movies, ...
%   num_features, lambda) returns the cost and gradient for the
%   collaborative filtering problem.
%

% Unfold the U and W matrices from params
X = reshape(params(1:num_movies*num_features), num_movies, num_features);
Theta = reshape(params(num_movies*num_features+1:end), ...
                num_users, num_features);

            
% You need to return the following values correctly
J = 0;
X_grad = zeros(size(X));
Theta_grad = zeros(size(Theta));

% ====================== YOUR CODE HERE ======================
% Instructions: Compute the cost function and gradient for collaborative
%               filtering. Concretely, you should first implement the cost
%               function (without regularization) and make sure it is
%               matches our costs. After that, you should implement the 
%               gradient and use the checkCostFunction routine to check
%               that the gradient is correct. Finally, you should implement
%               regularization.
%
% Notes: X - num_movies  x num_features matrix of movie features
%        Theta - num_users  x num_features matrix of user features
%        Y - num_movies x num_users matrix of user ratings of movies
%        R - num_movies x num_users matrix, where R(i, j) = 1 if the 
%            i-th movie was rated by the j-th user
%
% You should set the following variables correctly:
%
%        X_grad - num_movies x num_features matrix, containing the 
%                 partial derivatives w.r.t. to each element of X
%        Theta_grad - num_users x num_features matrix, containing the 
%                     partial derivatives w.r.t. to each element of Theta
%

h = X * Theta';
hR = h.*R;
diff = hR - Y;
diff2 = diff.^2;
J = 1/2 * sum(diff2(:));

%% X Gradient
for i = 1:(size(X)(1))
  idx = find(R(i, :) == 1); % list of all users that have rated movie i
  Theta_temp = Theta(idx,:);
  Y_temp = Y(i,idx);
  X_grad(i,:) = (X(i,:) * Theta_temp' - Y_temp) * Theta_temp;
endfor

%% Theta Gradient
for k = 1:(size(Theta)(1))
  idx = find(R(:, k) == 1); %% su an işlem yapılan kullanıcının oyladigi filmler
  X_temp = X(idx, :);
  Y_temp = Y(idx, k);
  Theta_temp = Theta(k,:);
  Theta_grad(k, :) = (X_temp * Theta_temp' - Y_temp)' * X_temp;
endfor

%% Cost Reg
Theta2 = Theta .^ 2;
Theta2_sum = sum(Theta2(:));

X2 = X .^ 2;
X2_sum = sum(X2(:));

J = J + (lambda/2) * Theta2_sum + (lambda/2) * X2_sum;

%% Gradient Reg
for k = 1:(size(X)(1))
  X_grad(k,:) = X_grad(k,:)  + lambda*X(k,:);
endfor

for k = 1:(size(Theta)(1))
  Theta_grad(k,:) = Theta_grad(k,:)  + lambda*Theta(k,:);
endfor

% =============================================================

grad = [X_grad(:); Theta_grad(:)];

end
