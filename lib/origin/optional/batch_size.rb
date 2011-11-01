# encoding: utf-8
module Origin
  module Optional
    module BatchSize

      def batch_size(value = nil)
        option(value) { |options| options.store(:batch_size, value) }
      end
    end
  end
end
