# encoding: utf-8
module Origin
  module Selection
    module Nin

      def nin(criterion = nil)
        send(strategy || :_intersect, criterion, "$nin")
      end

      ::Symbol.class_eval do

        def nin
          Key.new(self, "$nin")
        end
      end
    end
  end
end
