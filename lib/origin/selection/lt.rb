# encoding: utf-8
module Origin
  module Selection
    module Lt

      def lt(criterion = nil)
        __override__(criterion, "$lt")
      end

      ::Symbol.class_eval do

        def lt
          Key.new(self, "$lt")
        end
      end
    end
  end
end
