# encoding: utf-8
module Origin
  module Selection
    module Lte

      def lte(criterion = nil)
        _override(criterion, "$lte")
      end

      ::Symbol.class_eval do

        def lte
          Key.new(self, "$lte")
        end
      end
    end
  end
end
