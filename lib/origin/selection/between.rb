# encoding: utf-8
module Origin
  module Selection
    module Between

      def between(criterion = nil)
        assimilate(criterion) do |query, field, value|
          query.selector.store(
            field,
            { "$gte" => value.min, "$lte" => value.max }
          )
        end
      end
    end
  end
end
