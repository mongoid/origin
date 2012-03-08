# encoding: utf-8
module Origin
  module Selectable

    # The key is a representation of a field in a queryable, that can be
    # expanded to special MongoDB selectors.
    class Key

      # @attribute [r] name The name of the field.
      # @attribute [r] operator The MongoDB query operator.
      # @attribute [r] expanded The MongoDB expanded query operator.
      attr_reader :name, :operator, :expanded

      # Instantiate the new key.
      #
      # @example Instantiate the key.
      #   Key.new("age", "$gt")
      #
      # @param [ String, Symbol ] name The field name.
      # @param [ String ] operator The Mongo operator.
      # @param [ String ] expanded The Mongo expanded operator.
      #
      # @since 1.0.0
      def initialize(name, operator, expanded = nil)
        @name, @operator, @expanded = name, operator, expanded
      end

      # Gets the raw selector that would be passed to Mongo from this key.
      #
      # @example Specify the raw selector.
      #   key.specify(50)
      #
      # @param [ Object ] value The value to be included.
      #
      # @return [ Hash ] The raw MongoDB selector.
      #
      # @since 1.0.0
      def specify(value)
        { name.to_s => { operator => expanded ? { expanded => value } : value }}
      end

      # Get the key as raw Mongo sorting options.
      #
      # @example Get the key as a sort.
      #   key.as_sorting_options
      #
      # @return [ Hash ] The field/direction pair.
      #
      # @since 1.0.0
      def as_sorting_options
        { name => operator }
      end
    end
  end
end
