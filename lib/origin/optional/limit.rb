# encoding: utf-8
module Origin
  module Optional
    module Limit

      def limit(value = nil)
        option(value) { |options| options.store(:limit, value) }
      end
    end
  end
end
