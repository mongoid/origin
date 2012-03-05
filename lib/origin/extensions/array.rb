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
        if object.is_a?(Hash)
          object[object.keys.first] = __add__(object.values.first)
          object
        else
          concat(Array(object)).uniq
        end
      end

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
        [].tap do |copy|
          each do |value|
            copy.push(value.__deep_copy__)
          end
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
        if object.is_a?(Hash)
          object[object.keys.first] = __intersect__(object.values.first)
          object
        else
          self & Array(object)
        end
      end

      # Gets the array as options in the proper format to pass as MongoDB sort
      # criteria.
      #
      # @example Get the array as sorting options.
      #   [ :field, 1 ].as_sorting_options
      #
      # @return [ Hash ] The array as sort criterion.
      #
      # @since 1.0.0
      def as_sorting_options
        case first
        when Selectable::Key
          inject({}) do |hash, value|
            hash.tap { |_hash| _hash.merge!(value.as_sorting_options) }
          end
        when Array
          ::Hash[self].as_sorting_options
        else
          ::Hash[[ self ]].as_sorting_options
        end
      end

      def in_friendly
        self
      end
    end
  end
end

::Array.__send__(:include, Origin::Extensions::Array)
