# encoding: utf-8
module Origin
  module Selectable
    module In

      def in(criterion = nil)
        send(strategy || :__intersect__, criterion, "$in")
      end
      alias :any_in :in

      ::Symbol.add_key(:in, "$in")
    end
  end
end
