classdef Circle
    properties
        radius = 0;
    end
    methods
        function C = Circle(r)
            C.radius = r;
        end
        
        function r = diameter(C)
            r = C.radius.*2
        end
        function c = circumference(C)
            c = C.diameter().*pi
        end
        function a = area(C)
            a = (C.radius.^2).*pi
        end
                
    end
end
