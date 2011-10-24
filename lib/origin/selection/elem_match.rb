# encoding: utf-8
module Origin
  module Selection
    module ElemMatch

      def elem_match(criterion = nil)
        assimilate(criterion) do |query, field, value|
          query.selector.store(field, "$elemMatch" => value)
        end
      end

      ::Symbol.class_eval do

        def elem_match
          Key.new(self, "$elemMatch")
        end
      end
    end
  end
end
