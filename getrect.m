function [out] = getboundary(segim, segno)
    nseg = max(max(segim));
    segno = 1;
    B = segim==segno;
%     imshow(B);
    B1 = B;
    CC = bwconncomp(B);
    numOfPixels = cellfun(@numel,CC.PixelIdxList);
    [~,indexOfMax] = max(numOfPixels);
    B(CC.PixelIdxList{indexOfMax}) = 0;
    B = B1-B;
%     imshow(B);
    B = bwmorph(B,'remove');
    pts = find(B==1);
    [X,Y] = ndgrid(1:size(B,1),1:size(B,2));
    X = X(pts);
    Y = Y(pts);
    out = [X,Y];
end