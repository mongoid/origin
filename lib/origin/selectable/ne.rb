# encoding: utf-8
module Origin
  module Selectable
    module Ne

      def ne(criterion = nil)
        __override__(criterion, "$ne")
      end

      ::Symbol.class_eval do

        def ne
          Key.new(self, "$ne")
        end
      end
    end
  end
end
