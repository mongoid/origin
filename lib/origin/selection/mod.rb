# encoding: utf-8
module Origin
  module Selection
    module Mod

      def mod(criterion = nil)
        override!(criterion, "$mod")
      end

      ::Symbol.class_eval do

        def mod
          Key.new(self, "$mod")
        end
      end
    end
  end
end
