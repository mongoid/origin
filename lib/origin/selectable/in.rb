# encoding: utf-8
module Origin
  module Selectable
    module In

      def in(criterion = nil)
        send(strategy || :__intersect__, criterion, "$in")
      end

      ::Symbol.add_key(:in, "$in")
    end
  end
end
