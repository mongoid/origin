# encoding: utf-8
module Origin
  module Selection
    module Lt

      def lt(criterion = nil)
        _override(criterion, "$lt")
      end

      ::Symbol.class_eval do

        def lt
          Key.new(self, "$lt")
        end
      end
    end
  end
end
