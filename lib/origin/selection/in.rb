# encoding: utf-8
module Origin
  module Selection
    module In

      def in(criterion = nil)
        send(strategy || :_intersect, criterion, "$in")
      end

      ::Symbol.class_eval do

        def in
          Key.new(self, "$in")
        end
      end
    end
  end
end
