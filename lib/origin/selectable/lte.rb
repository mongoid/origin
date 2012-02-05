# encoding: utf-8
module Origin
  module Selectable
    module Lte

      def lte(criterion = nil)
        __override__(criterion, "$lte")
      end

      ::Symbol.class_eval do

        def lte
          Key.new(self, "$lte")
        end
      end
    end
  end
end
