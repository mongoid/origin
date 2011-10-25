# encoding: utf-8
module Origin
  module Selection
    class Key
      attr_reader :name, :operator, :expanded

      def initialize(name, operator, expanded = nil)
        @name, @operator, @expanded = name, operator, expanded
      end

      def specify(value)
        if expanded
          { name => { operator => { expanded => value }}}
        else
          { name => { operator => value }}
        end
      end
    end
  end
end
