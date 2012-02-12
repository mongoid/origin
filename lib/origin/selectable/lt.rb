# encoding: utf-8
module Origin
  module Selectable
    module Lt

      def lt(criterion = nil)
        __override__(criterion, "$lt")
      end

      ::Symbol.add_key(:lt, "$lt")
    end
  end
end
