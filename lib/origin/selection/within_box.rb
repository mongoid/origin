# encoding: utf-8
module Origin
  module Selection
    module WithinBox

      def within_box(criterion = nil)
        __expanded__(criterion, "$within", "$box")
      end

      ::Symbol.class_eval do

        def within_box
          Key.new(self, "$within", "$box")
        end
      end
    end
  end
end
