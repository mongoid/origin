# encoding: utf-8
module Origin
  module Extensions

    # This module contains additional object behaviour.
    module String

      def __evolve_date__
        time = ::Time.parse(self)
        ::Time.utc(time.year, time.month, time.day, 0, 0, 0, 0)
      end

      def __evolve_time__
        ::Time.parse(self).utc
      end

      # Get the string as a sort option.
      #
      # @example Get the string as a sort option.
      #   "field ASC".__sort_option__
      #
      # @return [ Hash ] The string as a sort option hash.
      #
      # @since 1.0.0
      def __sort_option__
        split(/,/).inject({}) do |hash, spec|
          hash.tap do |_hash|
            field, direction = spec.strip.split(/\s/)
            _hash[field.to_sym] = direction.to_direction
          end
        end
      end

      def field
        self
      end

      # Get the string as a specification.
      #
      # @example Get the string as a criteria.
      #   "field".specify(value)
      #
      # @param [ Object ] value The value of the criteria.
      #
      # @return [ Hash ] The selection.
      #
      # @since 1.0.0
      def specify(value)
        { self => value }
      end

      def strategy
        :__override__
      end

      # Get the string as a sort direction.
      #
      # @example Get the string as a sort direction.
      #   "1".to_direction
      #
      # @return [ Integer ] The direction.
      #
      # @since 1.0.0
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
          __evolve__(object) do |obj|
            obj.regexp? ? obj : obj.to_s
          end
        end
      end
    end
  end
end

::String.__send__(:include, Origin::Extensions::String)
::String.__send__(:extend, Origin::Extensions::String::ClassMethods)
