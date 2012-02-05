# encoding: utf-8
module Origin
  module Selectable
    module WithinCircle

      def within_circle(criterion = nil)
        __expanded__(criterion, "$within", "$center")
      end

      ::Symbol.class_eval do

        def within_circle
          Key.new(self, "$within", "$center")
        end
      end
    end
  end
end
