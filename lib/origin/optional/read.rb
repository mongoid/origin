# encoding: utf-8
module Origin
  module Optional
    module Read

      def read(node = nil)
        clone.tap do |query|
          query.options.store(:read, node) if node
        end
      end
    end
  end
end
