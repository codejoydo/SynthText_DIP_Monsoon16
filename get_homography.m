function [ H ] = get_homography( pts1,pts2 )
%Computes 2D-2D homography between two images given a set of points for
%matching points in 2 images
%

mean_pt = mean(pts1);
tx = [1 0 -mean_pt(1);0 1 -mean_pt(2);0 0 1];
mean_pt_re = repmat(mean_pt,size(pts1,1),1);
diff = pts1 - mean_pt_re;
dist = sqrt(sum(diff.^2,2));
mean_dist = mean(dist);
sx = [sqrt(2)/mean_dist 0 0;0 sqrt(2)/mean_dist 0;0 0 1];
T1 = sx*tx;
buff = ones(size(pts1,1),1);
pts1_homo = [pts1,buff];

pts1_norm = T1*pts1_homo';

%% FOR PTS1 END %%

%% FOR PTS2 %%

mean_pt = mean(pts2);
tx = [1 0 -mean_pt(1);0 1 -mean_pt(2);0 0 1];
mean_pt_re = repmat(mean_pt,size(pts2,1),1);
diff = pts1 - mean_pt_re;
dist = sqrt(sum(diff.^2,2));
mean_dist = mean(dist);
sx = [sqrt(2)/mean_dist 0 0;0 sqrt(2)/mean_dist 0;0 0 1];
T2 = sx*tx;
buff = ones(size(pts1,1),1);
pts2_homo = [pts2,buff];

pts2_norm = T2*pts2_homo';
%% FOR PTS2 END %%

A = zeros(2*size(pts1,1),9);
count = 0;
for i=1:2:size(A,1)
    count = count + 1;
    A(i,:) = [0 0 0 -pts2_norm(3,count)*pts1_norm(1,count) ...
        -pts2_norm(3,count)*pts1_norm(2,count) -pts2_norm(3,count)*pts1_norm(3,count)...
        pts2_norm(2,count)*pts1_norm(1,count) pts2_norm(2,count)*pts1_norm(2,count)...
        pts2_norm(2,count)*pts1_norm(3,count)];
    A(i+1,:) = [pts2_norm(3,count)*pts1_norm(1,count) pts2_norm(3,count)*pts1_norm(2,count)...
        pts2_norm(3,count)*pts1_norm(3,count) 0 0 0 -pts2_norm(1,count)*pts1_norm(1,count) ...
        -pts2_norm(1,count)*pts1_norm(2,count) -pts2_norm(1,count)*pts1_norm(3,count)];
end

[U S V] = svd(A);
P_col = V(:,end);
P = [ P_col(1:3)'; P_col(4:6)'; P_col(7:9)'];
H = inv(T2)*P*T1;

end