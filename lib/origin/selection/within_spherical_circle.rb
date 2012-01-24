# encoding: utf-8
module Origin
  module Selection
    module WithinSphericalCircle

      def within_spherical_circle(criterion = nil)
        __expanded__(criterion, "$within", "$centerSphere")
      end

      ::Symbol.class_eval do

        def within_spherical_circle
          Key.new(self, "$within", "$centerSphere")
        end
      end
    end
  end
end
