    load('Results/test1.mat');
c1=zeros(1,1,3);c1(:,:,1)=255;c1(:,:,2)=0;c1(:,:,3)=0;c1=uint8(c1);
c2=zeros(1,1,3);c2(:,:,1)=0;c2(:,:,2)=255;c2(:,:,3)=0;c2=uint8(c2);
c3=zeros(1,1,3);c3(:,:,1)=0;c3(:,:,2)=0;c3(:,:,3)=255;c3=uint8(c3);
c4=zeros(1,1,3);c4(:,:,1)=255;c4(:,:,2)=255;c4(:,:,3)=0;c4=uint8(c4);
c5=zeros(1,1,3);c5(:,:,1)=0;c5(:,:,2)=255;c5(:,:,3)=255;c5=uint8(c5);
c6=zeros(1,1,3);c6(:,:,1)=255;c6(:,:,2)=0;c6(:,:,3)=255;c6=uint8(c6);
out=uint8(zeros(size(O,1),size(O,2),3));
for i=1:size(O,1)
    for j=1:size(O,2)
        switch O(i,j)
            case 1
                out(i,j,:) = c1;
            case 2
                out(i,j,:) = c2;
            case 3
                out(i,j,:) = c3;
            case 4
                out(i,j,:) = c4;
            case 5
                out(i,j,:) = c5;
            case 6
                out(i,j,:) = c6;
        end
    end
end
 imwrite(out,'Results/t1.jpg');