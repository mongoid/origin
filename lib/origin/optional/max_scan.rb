# encoding: utf-8
module Origin
  module Optional
    module MaxScan

      def max_scan(value = nil)
        option(value) { |options| options.store(:max_scan, value) }
      end
    end
  end
end
