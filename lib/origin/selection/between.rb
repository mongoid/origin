# encoding: utf-8
module Origin
  module Selection
    module Between

      def between(criterion = nil)
        clone.tap do |query|
          if criterion
            criterion.each_pair do |field, range|
              query.selector.store(
                field,
                { "$gte" => range.min, "$lte" => range.max }
              )
            end
          end
        end
      end
    end
  end
end
