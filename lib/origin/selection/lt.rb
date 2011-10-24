# encoding: utf-8
module Origin
  module Selection
    module Lt

      def lt(criterion = nil)
        assimilate(criterion) do |query, field, value|
          query.selector.store(field, { "$lt" => value })
        end
      end

      ::Symbol.class_eval do

        def lt
          Key.new(self, "$lt")
        end
      end
    end
  end
end
