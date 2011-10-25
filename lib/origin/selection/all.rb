# encoding: utf-8
module Origin
  module Selection
    module All

      def all(criterion = nil)
        send(strategy || :override!, criterion, "$all")
      end

      ::Symbol.class_eval do

        def all
          Key.new(self, "$all")
        end
      end
    end
  end
end
