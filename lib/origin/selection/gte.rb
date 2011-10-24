# encoding: utf-8
module Origin
  module Selection
    module Gte

      def gte(criterion = nil)
        assimilate(criterion) do |query, field, value|
          query.selector.store(field, { "$gte" => value })
        end
      end

      ::Symbol.class_eval do

        def gte
          Key.new(self, "$gte")
        end
      end
    end
  end
end
