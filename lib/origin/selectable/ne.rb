# encoding: utf-8
module Origin
  module Selectable
    module Ne

      def ne(criterion = nil)
        __override__(criterion, "$ne")
      end

      ::Symbol.add_key(:ne, "$ne")
    end
  end
end
