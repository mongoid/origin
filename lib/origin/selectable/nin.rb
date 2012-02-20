# encoding: utf-8
module Origin
  module Selectable
    module Nin

      def nin(criterion = nil)
        send(strategy || :__intersect__, criterion, "$nin")
      end
      alias :not_in :nin

      ::Symbol.add_key(:nin, "$nin")
    end
  end
end
