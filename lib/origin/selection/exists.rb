# encoding: utf-8
module Origin
  module Selection
    module Exists

      def exists(criterion = nil)
        assimilate(criterion) do |query, field, value|
          query.selector.store(field, "$exists" => value)
        end
      end

      ::Symbol.class_eval do

        def exists
          Key.new(self.to_s, "$exists")
        end
      end
    end
  end
end
