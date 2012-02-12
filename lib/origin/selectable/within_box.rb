# encoding: utf-8
module Origin
  module Selectable
    module WithinBox

      def within_box(criterion = nil)
        __expanded__(criterion, "$within", "$box")
      end

      ::Symbol.add_multi_key(:within_box, "$within", "$box")
    end
  end
end
