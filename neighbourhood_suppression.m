I=load('./Results/test17.mat');
%figure,imshow(I,[]);
r=size(I,1);
c=size(I,2);

FI=I;

for i=2:r-1
    for j=2:c-1
         W=I(i-1:i+1,j-1:j+1);
         mn=min(min(W));
         mx=max(max(W));
         if mn==mx
             continue
         else
             A=[W(1,:);W(2,:);W(3,:)];
             FI(r,c)=mode(A);
        end
    end
end
%figure,imshow(FI,[])
save('./SuppressionResults/test17.mat','FI');