# encoding: utf-8
module Origin
  module Selectable
    module WithinSphericalCircle

      def within_spherical_circle(criterion = nil)
        __expanded__(criterion, "$within", "$centerSphere")
      end

      ::Symbol.add_multi_key(:within_spherical_circle, "$within", "$centerSphere")
    end
  end
end
