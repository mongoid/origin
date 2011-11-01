# encoding: utf-8
module Origin
  module Optional
    module Transformer

      def transformer(block = nil)
        option(block) { |options| options.store(:transformer, block) }
      end
    end
  end
end
