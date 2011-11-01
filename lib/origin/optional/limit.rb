# encoding: utf-8
module Origin
  module Optional
    module Limit

      def limit(value = nil)
        clone.tap do |query|
          query.options.store(:limit, value) if value
        end
      end
    end
  end
end
