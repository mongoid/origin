# encoding: utf-8
module Origin
  module Selectable
    module Mod

      def mod(criterion = nil)
        __override__(criterion, "$mod")
      end

      ::Symbol.add_key(:mod, "$mod")
    end
  end
end
