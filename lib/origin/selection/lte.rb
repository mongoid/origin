# encoding: utf-8
module Origin
  module Selection
    module Lte

      def lte(criterion = nil)
        assimilate(criterion) do |query, field, value|
          query.selector.store(field, { "$lte" => value })
        end
      end

      ::Symbol.class_eval do

        def lte
          Key.new(self, "$lte")
        end
      end
    end
  end
end
