# encoding: utf-8
module Origin
  module Selection
    module Gte

      def gte(criterion = nil)
        override(criterion, "$gte")
      end

      ::Symbol.class_eval do

        def gte
          Key.new(self, "$gte")
        end
      end
    end
  end
end
