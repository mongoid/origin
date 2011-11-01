# encoding: utf-8
module Origin
  module Optional
    module Read

      def read(node = nil)
        option(node) { |options| options.store(:read, node) }
      end
    end
  end
end
