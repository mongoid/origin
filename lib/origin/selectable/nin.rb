# encoding: utf-8
module Origin
  module Selectable
    module Nin

      def nin(criterion = nil)
        send(strategy || :__intersect__, criterion, "$nin")
      end

      ::Symbol.class_eval do

        def nin
          Key.new(self, "$nin")
        end
      end
    end
  end
end
