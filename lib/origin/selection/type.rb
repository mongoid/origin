# encoding: utf-8
module Origin
  module Selection
    module Type

      def type(criterion = nil)
        assimilate(criterion) do |query, field, value|
          query.selector.store(field, { "$type" => value })
        end
      end

      ::Symbol.class_eval do

        def type
          Key.new(self, "$type")
        end
      end
    end
  end
end
