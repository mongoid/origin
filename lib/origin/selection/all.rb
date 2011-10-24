# encoding: utf-8
module Origin
  module Selection
    module All

      def all(criterion = nil)
        assimilate(criterion) do |query, field, value|
          query.selector.store(field, { "$all" => value })
        end
      end

      ::Symbol.class_eval do

        def all
          Key.new(self, "$all")
        end
      end
    end
  end
end
