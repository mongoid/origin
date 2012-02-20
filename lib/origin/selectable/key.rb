# encoding: utf-8
module Origin
  module Selectable
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

      def as_sorting_options
        { name => operator }
      end
    end
  end
end
