# encoding: utf-8
module Origin
  module Selectable
    module Lte

      def lte(criterion = nil)
        __override__(criterion, "$lte")
      end

      ::Symbol.add_key(:lte, "$lte")
    end
  end
end
