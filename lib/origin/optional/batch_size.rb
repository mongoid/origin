# encoding: utf-8
module Origin
  module Optional
    module BatchSize

      def batch_size(value = nil)
        clone.tap do |query|
          query.options.store(:batch_size, value) if value
        end
      end
    end
  end
end
