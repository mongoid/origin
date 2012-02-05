# encoding: utf-8
module Origin
  module Selectable
    module Exists

      def exists(criterion = nil)
        __override__(criterion, "$exists")
      end

      ::Symbol.class_eval do

        def exists
          Key.new(self, "$exists")
        end
      end
    end
  end
end
