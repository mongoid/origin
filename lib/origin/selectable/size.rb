# encoding: utf-8
module Origin
  module Selectable
    module Size

      def with_size(criterion = nil)
        __override__(criterion, "$size")
      end

      ::Symbol.add_key(:with_size, "$size")
    end
  end
end
