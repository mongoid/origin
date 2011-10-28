# encoding: utf-8
module Origin
  module Selection
    module Near

      def near(criterion = nil)
        _override(criterion, "$near")
      end

      ::Symbol.class_eval do

        def near
          Key.new(self, "$near")
        end
      end
    end
  end
end
