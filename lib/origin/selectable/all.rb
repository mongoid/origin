# encoding: utf-8
module Origin
  module Selectable
    module All

      def all(criterion = nil)
        send(strategy || :__override__, criterion, "$all")
      end
      alias :all_in :all

      ::Symbol.add_key(:all, "$all")
    end
  end
end
