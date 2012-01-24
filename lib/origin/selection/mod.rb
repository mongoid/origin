# encoding: utf-8
module Origin
  module Selection
    module Mod

      def mod(criterion = nil)
        __override__(criterion, "$mod")
      end

      ::Symbol.class_eval do

        def mod
          Key.new(self, "$mod")
        end
      end
    end
  end
end
