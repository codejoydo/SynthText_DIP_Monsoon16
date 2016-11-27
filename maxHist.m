function [max_area,ret_val] = maxHist(row)
stack=[];
top_val=0;
ret_val=0;
C=size(row,2);
max_area = 0;
i = 1;
while i <= C
    if size(stack,2)==0
        stack=[i,stack];
        i=i+1;
    elseif  row(stack(1))<=row(i)
        stack=[i,stack];
        i=i+1;
    else
        top_val=row(stack(1));
        stack=stack(2:end);
        area=top_val*(i-1);
        if size(stack,2)~=0
            area = top_val * (i - stack(1)-1);
        end
        if max_area < area
            max_area = area;
            ret_val = top_val;
        end
    end
end

while size(stack,2)~=0
    
    top_val = row(stack(1));
    stack=stack(2:end);
    area = top_val * (i-1);
    if size(stack,2)~=0
        area = top_val * (i - stack(1)-1);
    end
    if max_area < area
        max_area = area;
        ret_val = top_val;
    end
end

end
