# encoding: utf-8
module Origin
  module Extensions

    # The array module adds custom behaviour for Origin onto the Array class.
    module Array

      # Combine the two objects using the add strategy.
      #
      # @example Add the object to the array.
      #   [ 1, 2, 3 ].__add__(4)
      #
      # @param [ Object ] object The object to add.
      #
      # @return [ Object ] The result of the add.
      #
      # @since 1.0.0
      def __add__(object)
        object.__add_from_array__(self)
      end

      # Return the object as an array.
      #
      # @example Get the array.
      #   [ 1, 2 ].__array__
      #
      # @return [ Array ] self
      #
      # @since 1.0.0
      def __array__; self; end

      # Makes a deep copy of the array, deep copying every element inside the
      # array.
      #
      # @example Get a deep copy of the array.
      #   [ 1, 2, 3 ].__deep_copy__
      #
      # @return [ Array ] The deep copy of the array.
      #
      # @since 1.0.0
      def __deep_copy__
        map do |value|
          value.__deep_copy__
        end
      end

      # Combine the two objects using an intersection strategy.
      #
      # @example Interset with the object.
      #   [ 1, 2 ].__intersect__(3)
      #
      # @param [ Object ] object The object to intersect with.
      #
      # @return [ Object ] The result of the intersection.
      #
      # @since 1.0.0
      def __intersect__(object)
        object.__intersect_from_array__(self)
      end

      # Gets the array as options in the proper format to pass as MongoDB sort
      # criteria.
      #
      # @example Get the array as sorting options.
      #   [ :field, 1 ].__sort_option__
      #
      # @return [ Hash ] The array as sort criterion.
      #
      # @since 1.0.0
      def __sort_option__
        multi.inject({}) do |options, criteria|
          options.merge!(criteria.__sort_pair__)
          options
        end
      end

      # Get the array as a sort pair.
      #
      # @example Get the array as field/direction pair.
      #   [ 1, 2, 3 ].__sort_pair__
      #
      # @return [ Hash ] The field/direction pair.
      #
      # @since 1.0.0
      def __sort_pair__
        { first => last.to_direction }
      end

      private

      # Converts the array to a multi-dimensional array.
      #
      # @api private
      #
      # @example Convert to multi-dimensional.
      #   [ 1, 2, 3 ].multi
      #
      # @return [ Array ] The multi-dimensional array.
      #
      # @since 1.0.0
      def multi
        first.is_a?(::Symbol) ? [ self ] : self
      end

      module ClassMethods

        # Evolve the object when the serializer is defined as an array.
        #
        # @example Evolve the object.
        #   Array.evolve(1)
        #
        # @param [ Object ] The object to evolve.
        #
        # @return [ Object ] The evolved object.
        #
        # @since 1.0.0
        def evolve(object)
          if object.is_a?(::Array)
            object.map!{ |obj| obj.class.evolve(obj) }
          else
            object
          end
        end
      end
    end
  end
end

::Array.__send__(:include, Origin::Extensions::Array)
::Array.__send__(:extend, Origin::Extensions::Array::ClassMethods)
