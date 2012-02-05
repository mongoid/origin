# encoding: utf-8
module Origin
  module Selectable
    module NearSphere

      def near_sphere(criterion = nil)
        __override__(criterion, "$nearSphere")
      end

      ::Symbol.class_eval do

        def near_sphere
          Key.new(self, "$nearSphere")
        end
      end
    end
  end
end
