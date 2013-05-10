module Origin

  module Aggregatable

    class Operation

      attr_reader :operator

      def name
        raise NotImplementedError, "This method should be implemented by all operations"
      end

      def initialize(options = {})
        @operator = options
      end

    end

  end

end
