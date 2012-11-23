module Origin

  module Aggregatable

    class Unwind < Operation

      def name
        "$unwind"
      end

      def initialize(options = nil)
        @operator = "$#{options}"
      end

    end

  end

end
