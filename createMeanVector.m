% This function isn't even used anymore since we use MATLAB's built in
% Na�ve Bayes classifier.
function mvec = createMeanVector( vecs )
  
  new_vecs = cell2mat(vecs);
  tmp_vec = zeros(size(new_vecs(1)));
  num_vecs = 7; % size(new_vecs); % we know this will be 7
  
  for i = 1 : num_vecs
    tmp_vec = tmp_vec + new_vecs(i);
  end
  
  mvec = tmp_vec / num_vecs;

end