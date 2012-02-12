# encoding: utf-8
module Origin
  module Selectable
    module NearSphere

      def near_sphere(criterion = nil)
        __override__(criterion, "$nearSphere")
      end

      ::Symbol.add_key(:near_sphere, "$nearSphere")
    end
  end
end
