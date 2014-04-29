classdef rcmPose
    %TESTCLASS Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        config = rcmConfig(0, 0, 0, 0, 0)
        theta1 = 0;
        theta2 = 0;
        Tx = 0;
        Ty = 0;
        Tz = 0;
        r = 0;
    end
    
    methods
        function obj = rcmPose (t1, t2, tx, ty, tz, r, cfg)
            obj.theta1 = t1;
            obj.theta2 = t2;
            obj.Tx = tx;
            obj.Ty = ty;
            obj.Tz = tz;
            if nargin > 5
                obj.r = min(max(r, 0), 1);
                if nargin > 6
                    obj.config = cfg;
                end
            end
        end
        
        function plot(RCM)

            L1 = RCM.config.L1
            L2 = RCM.config.L2
            
            X0 = RCM.config.offset(1)
            Y0 = RCM.config.offset(2)
            Z0 = RCM.config.offset(3)
            
            X = RCM.Tx
            Y = RCM.Ty
            Z = RCM.Tz
            
            PlotRCM(X, Y, Z, RCM.theta1, RCM.theta2, L1, L2, RCM.r, X0,Y0,Z0)

        end
    end
    
end

