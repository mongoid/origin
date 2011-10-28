# encoding: utf-8
module Origin
  module Selection
    module Size

      def with_size(criterion = nil)
        _override(criterion, "$size")
      end

      ::Symbol.class_eval do

        def with_size
          Key.new(self, "$size")
        end
      end
    end
  end
end
