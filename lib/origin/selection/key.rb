# encoding: utf-8
module Origin
  module Selection
    class Key
      attr_reader :name, :operator

      def initialize(name, operator)
        @name, @operator = name, operator
      end

      def specify(value)
        { name => { operator => value } }
      end
    end
  end
end
