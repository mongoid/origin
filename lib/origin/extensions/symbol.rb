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
        #
        # @since 1.0.0
        def add_key(name, operator, &block)
          define_method(name) do
            Key.new(self, operator, &block)
          end
        end

        # Adds a method on symbol as a convenience for the MongoDB operator.
        #
        # @example Add the $within/$center method.
        #   Symbol.add_key(:within_circle, "$within", "$center")
        #
        # @param [ Symbol ] name The name of the method.
        # @param [ String ] outer The MongoDB outer operator.
        # @param [ String ] inner The MongoDB inner operator.
        #
        # @since 1.0.0
        def add_multi_key(name, outer, inner, &block)
          define_method(name) do
            Key.new(self, outer, inner, &block)
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
