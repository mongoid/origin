# encoding: utf-8
module Origin
  module Selection
    module Type

      def type(criterion = nil)
        __override__(criterion, "$type")
      end

      ::Symbol.class_eval do

        def type
          Key.new(self, "$type")
        end
      end
    end
  end
end
