# encoding: utf-8
module Origin
  module Selectable
    module Between

      def between(criterion = nil)
        selection(criterion) do |selector, field, value|
          selector.store(
            field,
            { "$gte" => value.min, "$lte" => value.max }
          )
        end
      end
    end
  end
end
