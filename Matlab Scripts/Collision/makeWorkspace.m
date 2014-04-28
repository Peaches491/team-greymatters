function [ ws ] = makeWorkspace( c, wswidth, res)
%MAKEWORKSPACE Summary of this function goes here
%   Detailed explanation goes here

    if nargin < 3
        res = 0.01;
    end
    
%     i = 0;
%     wswidth = wswidth /2;
%     del = wswidth/res;
%     ws = zeros((2*wswidth/del)*3, 3);
%     if res ~= 0
%         for x = -1*wswidth:del:wswidth
%             for y = -1*wswidth:del:wswidth
%                 for z = -1*wswidth:del:wswidth
%                     if(sqrt(sum([x, y, z].^2))) < wswidth*0.9
%                         ws(i+1, :) = [x, y, z] + c;
%                         i = i+1;
%                     end
%                 end 
%             end    
%         end
%     else
%         ws = c;
%     end


    ws = zeros(7, 3);
    
    ws(1, :) = c + [0, 0,  0];
    ws(2, :) = c + [0, 0,  wswidth];
    ws(3, :) = c + [0, 0, -wswidth];
    ws(4, :) = c + [0,  wswidth, 0];
    ws(5, :) = c + [0, -wswidth, 0];
    ws(6, :) = c + [ wswidth, 0, 0];
    ws(7, :) = c + [-wswidth, 0, 0];
    
end

