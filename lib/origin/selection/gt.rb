# encoding: utf-8
module Origin
  module Selection
    module Gt

      def gt(criterion = nil)
        assimilate(criterion) do |query, field, value|
          query.selector.store(field, { "$gt" => value })
        end
      end

      ::Symbol.class_eval do

        def gt
          Key.new(self, "$gt")
        end
      end
    end
  end
end
