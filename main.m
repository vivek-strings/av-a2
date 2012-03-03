function ret = main()
  bg = imread('background1.jpg');
  bg2 = imread('background2.jpg');
  bgs = { bg bg2 };
  
  train_sets_paper = { '1-1/' '1-2/' '1-3/' '2-2/' '2-5/' '3-7/' '3-8/' '3-9/' }; % test using '3-9/' };
  train_sets_scissors = { '1-7/' '1-8/' '1-9/' '2-1/' '2-4/' '3-4/' '3-5/' '3-6/' }; % test using '3-6/' };
  train_sets_rock = { '1-4/' '1-5/' '1-6/' '2-3/' '2-6/' '3-1/' '3-2/' '3-3/' }; % test using '3-3/' };
  
  p_moms = [];
  s_moms = [];
  r_moms = [];
  
  naive_training = [];
  naive_classes = {};
  cc = 1;
  
  sizey = size(train_sets_paper);
  tnum = sizey(2); % 7
  
%   % for paper
%   for i = 1 : tnum
%     im_dir = strcat('av212data/train/', train_sets_paper{i});
%     images = removeBackgroundFromImageSet(bgs, im_dir);
% 
%     [l u r d] = getSequenceBoundingBox(images);
%     mhi = createMHI(images, [l u r d]);
%     mhi_moms = getMomentInvDesc(mhi);
% 
%     p_moms = [p_moms ; mhi_moms];
%     naive_training = [naive_training ; mhi_moms];
%     naive_classes{cc} = 'paper';
%     cc = cc + 1;
%     pp = i % this gives us an idea of how long things are taking
%   end
%   
%   pp = 'Done with paper'
%   
%   % for scissors
%   for i = 1 : tnum
%     im_dir = strcat('av212data/train/', train_sets_scissors{i});
%     images = removeBackgroundFromImageSet(bgs, im_dir);
% 
%     [l u r d] = getSequenceBoundingBox(images);
%     mhi = createMHI(images, [l u r d]);
%     mhi_moms = getMomentInvDesc(mhi);
% 
%     s_moms = [s_moms ; mhi_moms];
%     naive_training = [naive_training ; mhi_moms];
%     naive_classes{cc} = 'scissors';
%     cc = cc + 1;
%     pp = i
%   end
%   
%   pp = 'Done with scissors'
%   
%   % for rock
%   for i = 1 : tnum
%     im_dir = strcat('av212data/train/', train_sets_rock{i});
%     images = removeBackgroundFromImageSet(bgs, im_dir);
% 
%     [l u r d] = getSequenceBoundingBox(images);
%     mhi = createMHI(images, [l u r d]);
%     mhi_moms = getMomentInvDesc(mhi);
% 
%     r_moms = [r_moms ; mhi_moms];
%     naive_training = [naive_training ; mhi_moms];
%     naive_classes{cc} = 'rock';
%     cc = cc + 1;
%     pp = i
%   end
%   
%   pp = 'Done with rock'
  
  % This bit has some hardcoded values (e.g. 24).
  all_moms = importdata('naive_training.txt');
  p_test = [];
  s_test = [];
  r_test = [];
  for i = 1 : 24
    mom = [all_moms(i,1) all_moms(i,2) all_moms(i,3) all_moms(i,4) all_moms(i,5) all_moms(i,6) all_moms(i,7)];
    if (i<8)
      naive_training = [naive_training ; mom];
    end
    if (i==8)
      p_test = mom;
    end
    
    if (i>8 && i<16)
      naive_training = [naive_training ; mom];
    end
    if (i==16)
      s_test = mom;
    end
    
    if (i>16 && i<24)
      naive_training = [naive_training ; mom];
    end
    if (i==24)
      r_test = mom;
    end
  end
  
  for i=1 : 21
    if (i<=7)
      naive_classes{i} = 'paper';
    end
    if (i>7 && i<=14)
      naive_classes{i} = 'scissors';
    end
    if (i>14)
      naive_classes{i} = 'rock';
    end
  end
  % end of hardcoding
  
  pp = 'Starting bayes'
  
  nc = naive_classes';
  
  % only needed to do this once
  % save 'naive_training.txt' naive_training '-ASCII';
  
  % create a naive bayes classifier and fit our trainig data.
  nb = NaiveBayes.fit(naive_training, nc);
  
  pt = nb.predict(p_test)
  st = nb.predict(s_test)
  rt = nb.predict(r_test)
  
  ret = nb;
  
end

