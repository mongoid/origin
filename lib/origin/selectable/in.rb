# encoding: utf-8
module Origin
  module Selectable
    module In

      def in(criterion = nil)
        send(strategy || :__intersect__, criterion, "$in")
      end

      ::Symbol.class_eval do

        def in
          Key.new(self, "$in")
        end
      end
    end
  end
end
