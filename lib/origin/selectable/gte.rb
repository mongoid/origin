# encoding: utf-8
module Origin
  module Selectable
    module Gte

      def gte(criterion = nil)
        __override__(criterion, "$gte")
      end

      ::Symbol.add_key(:gte, "$gte")
    end
  end
end
