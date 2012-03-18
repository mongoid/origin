# encoding: utf-8
module Origin
  module Extensions

    # This module contains additional symbol behaviour.
    module Symbol

      # Get the symbol as a specification.
      #
      # @example Get the symbol as a criteria.
      #   :field.specify(value)
      #
      # @param [ Object ] value The value of the criteria.
      #
      # @return [ Hash ] The selection.
      #
      # @since 1.0.0
      def specify(value)
        { self => value }
      end

      # Get the symbol as a sort direction.
      #
      # @example Get the symbol as a sort direction.
      #   "1".to_direction
      #
      # @return [ Integer ] The direction.
      #
      # @since 1.0.0
      def to_direction
        to_s.to_direction
      end

      module ClassMethods

        # Adds a method on symbol as a convenience for the MongoDB operator.
        #
        # @example Add the $in method.
        #   Symbol.add_key(:in, "$in")
        #
        # @param [ Symbol ] name The name of the method.
        # @param [ String ] operator The MongoDB operator.
        # @param [ String ] additional The additional MongoDB operator.
        #
        # @since 1.0.0
        def add_key(name, operator, additional = nil, &block)
          define_method(name) do
            Key.new(self, operator, additional, &block)
          end
        end

        # Evolves the symbol into a MongoDB friendly value - in this case
        # a symbol.
        #
        # @example Evolve the symbol
        #   Symbol.evolve("test")
        #
        # @param [ Object ] object The object to convert.
        #
        # @return [ Symbol ] The value as a symbol.
        #
        # @since 1.0.0
        def evolve(object)
          __evolve__(object) { |obj| obj ? obj.to_sym : obj }
        end
      end
    end
  end
end

::Symbol.__send__(:include, Origin::Extensions::Symbol)
::Symbol.__send__(:extend, Origin::Extensions::Symbol::ClassMethods)
