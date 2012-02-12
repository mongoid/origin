# encoding: utf-8
module Origin
  module Selectable
    module Gt

      def gt(criterion = nil)
        __override__(criterion, "$gt")
      end

      ::Symbol.add_key(:gt, "$gt")
    end
  end
end
