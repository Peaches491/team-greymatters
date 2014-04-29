classdef rcmConfig
    %RCMCONFIG Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        L1 = 0;
        L2 = 0;
        L3 = 0;
        r1 = 0;
        r2 = 0;
        offset = [0, 0, 0];
        fitness = 0;
    end
    
    methods
        function obj = rcmConfig (L1, L2, L3, r1, r2, offset, fitness)
            obj.L1 = L1;
            obj.L2 = L2;
            obj.L3 = L3;
            obj.r1 = min(r1, L1/2);
            obj.r2 = min(r2, L2/2);
            if nargin > 5
                obj.offset = offset;
                if nargin > 6
                    obj.fitness = fitness;
                end
            end
        end
    end
    
    methods(Static)
        function objs = makePopulation(pop_size, L3, offset)
            objs = rcmConfig.empty();
            
            L1 = .5;
            L2 = .5;
            r1 = L1/2;
            r2 = L2/2;
            
            for x = 1:pop_size
                objs(x) = rcmConfig(L1*rand(), L2*rand(), L3, ...
                    r1*rand(), r2*rand(), offset);
            end
        end
    end
end


