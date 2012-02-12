# encoding: utf-8
module Origin
  module Selectable
    module WithinCircle

      def within_circle(criterion = nil)
        __expanded__(criterion, "$within", "$center")
      end

      ::Symbol.add_multi_key(:within_circle, "$within", "$center")
    end
  end
end
