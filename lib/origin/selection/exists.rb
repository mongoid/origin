# encoding: utf-8
module Origin
  module Selection
    module Exists

      def exists(criterion = nil)
        _override(criterion, "$exists")
      end

      ::Symbol.class_eval do

        def exists
          Key.new(self, "$exists")
        end
      end
    end
  end
end
