# encoding: utf-8
module Origin
  module Extensions
    module String

      def as_sorting_options
        split(/,/).inject({}) do |hash, spec|
          hash.tap do |_hash|
            field, direction = spec.strip.split(/\s/)
            _hash[field.to_sym] = direction.to_direction
          end
        end
      end

      def specify(value)
        { self => value }
      end

      def to_direction
        self =~ /desc/i ? -1 : 1
      end

      module ClassMethods

        # Evolves the string into a MongoDB friendly value - in this case
        # a string.
        #
        # @example Evolve the string
        #   String.evolve(1)
        #
        # @param [ Object ] object The object to convert.
        #
        # @return [ String ] The value as a string.
        #
        # @since 1.0.0
        def evolve(object)
          __evolve__(object) { |obj| obj.to_s }
        end
      end
    end
  end
end

::String.__send__(:include, Origin::Extensions::String)
::String.__send__(:extend, Origin::Extensions::String::ClassMethods)
