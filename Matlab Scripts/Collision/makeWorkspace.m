function [ ws ] = makeWorkspace( c, wswidth, res)
%MAKEWORKSPACE Summary of this function goes here
%   Detailed explanation goes here

    i = 0;
    wswidth = wswidth /2;
    del = wswidth/res;
    ws = zeros((2*wswidth/del)*3, 3);
    for x = -1*wswidth:del:wswidth
        for y = -1*wswidth:del:wswidth
            for z = -1*wswidth:del:wswidth
                if(sqrt(sum([x, y, z].^2))) < wswidth*0.9
                    ws(i+1, :) = [x, y, z] + c;
                    i = i+1;
                end
            end 
        end    
    end
end

