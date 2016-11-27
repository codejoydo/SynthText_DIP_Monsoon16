function [sx,sy,ex,ey]=max_areaRect(M)
%% A function  which returns the area of maximum rectangle occupied by 1 in a binary matrix,along with the coordinates of the end pointin the matrix.


DP=zeros(size(M,1),size(M,2));
r=size(M,1);
c=size(M,2);
DP(1,1)=M(1,1);
A=0;
x=0;
y=0;
l=0;
h=0;
% For first row
for i=2:c
    if M(1,i)==1
        DP(1,i)=DP(1,i-1)+1;
    end
    if DP(1,i)>A
        A=DP(1,i);
        x=1;
        y=i;
    end
end

%Propogating the DP

for i=2:r
    for j=1:c
        
        if M(i,j)==1
            DP(i,j)=DP(i-1,j)+1;
        end
    end
    [max_area,ret_val]=maxHist(DP(i,:));
    row = DP(i,:);
    ind = find(row>=ret_val);
    %     disp(ind);
    %     disp(ret_val);
    %      disp([i,max_area,ret_val,ind(end)]);
    if max_area > A
        A=max_area;
        x=i;
        y=ind(end);
        l=ind(end)-ind(1)+1;
        h=A/l;
    end
    sy = y-l+1;
    sx = x-h+1;
    ex = x;
    ey = y;
end

end