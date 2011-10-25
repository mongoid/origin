# encoding: utf-8
module Origin
  module Selection
    module NearSphere

      def near_sphere(criterion = nil)
        override!(criterion, "$nearSphere")
      end

      ::Symbol.class_eval do

        def near_sphere
          Key.new(self, "$nearSphere")
        end
      end
    end
  end
end
