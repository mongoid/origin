# encoding: utf-8
module Origin
  module Selectable
    module Exists

      def exists(criterion = nil)
        __override__(criterion, "$exists")
      end

      ::Symbol.add_key(:exists, "$exists")
    end
  end
end
