# encoding: utf-8
module Origin
  module Selectable
    module Type

      def type(criterion = nil)
        __override__(criterion, "$type")
      end

      ::Symbol.add_key(:type, "$type")
    end
  end
end
