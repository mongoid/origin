# encoding: utf-8
module Origin
  module Optional
    module Snapshot

      def snapshot
        clone.tap do |query|
          query.options.store(:snapshot, true)
        end
      end
    end
  end
end
