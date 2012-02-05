# encoding: utf-8
module Origin
  module Selectable
    module Gt

      def gt(criterion = nil)
        __override__(criterion, "$gt")
      end

      ::Symbol.class_eval do

        def gt
          Key.new(self, "$gt")
        end
      end
    end
  end
end
