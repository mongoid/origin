# encoding: utf-8
module Origin
  module Selectable
    module Near

      def near(criterion = nil)
        __override__(criterion, "$near")
      end

      ::Symbol.add_key(:near, "$near")
    end
  end
end
