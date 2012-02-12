# encoding: utf-8
module Origin
  module Selectable
    module All

      def all(criterion = nil)
        send(strategy || :__override__, criterion, "$all")
      end

      ::Symbol.add_key(:all, "$all")
    end
  end
end
