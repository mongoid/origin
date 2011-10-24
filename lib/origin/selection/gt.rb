# encoding: utf-8
module Origin
  module Selection
    module Gt

      def gt(criterion = nil)
        override!(criterion, "$gt")
      end

      ::Symbol.class_eval do

        def gt
          Key.new(self, "$gt")
        end
      end
    end
  end
end
