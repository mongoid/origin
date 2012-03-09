# encoding: utf-8
module Origin

  # The selector is a special kind of hash that knows how to serialize values
  # coming into it as well as being alias and locale aware for key names.
  class Selector < Hash

    # @attribute [r] aliases The aliases.
    # @attribute [r] serializers The serializers.
    attr_reader :aliases, :serializers

    # Initialize the new selector.
    #
    # @example Initialize the new selector.
    #   Origin::Selector.new(aliases, serializers)
    #
    # @param [ Hash ] aliases A hash of mappings from aliases to the actual
    #   field names in the database.
    # @param [ Hash ] serializers An optional hash of objects that are
    #   responsible for serializing values. The keys of the hash must be
    #   strings that match the field name, and the values must respond to
    #   #localized? and #evolve(object).
    #
    # @since 1.0.0
    def initialize(aliases = {}, serializers = {})
      @aliases, @serializers = aliases, serializers
    end

    # Store the value in the selector for the provided key. The selector will
    # handle all necessary serialization and localization in this step.
    #
    # @example Store a value in the selector.
    #   selector.store(:key, "testing")
    #
    # @param [ String, Symbol ] key The name of the attribute.
    # @param [ Object ] value The value to add.
    #
    # @return [ Object ] The stored object.
    #
    # @since 1.0.0
    def store(key, value)
      field = key.to_s
      name = aliases[field] || field
      serializer = serializers[name]
      if multi_selection?(name)
        super(name, evolve_multi(value))
      else
        super(normalized_key(name, serializer), evolve(serializer, value))
      end
    end
    alias :[]= :store

    private

    # Evolves a multi-list selection, like an $and or $or criterion, and
    # performs the necessary serialization.
    #
    # @api private
    #
    # @example Evolve the multi-selection.
    #   selector.evolve_multi([{ field: "value" }])
    #
    # @param [ Array<Hash> ] The multi-selection.
    #
    # @return [ Array<Hash> ] The serialized values.
    #
    # @since 1.0.0
    def evolve_multi(value)
      value.map do |val|
        Hash[val.map do |key, _value|
          name = key.to_s
          serializer = serializers[name]
          [ normalized_key(name, serializer), evolve(serializer, _value) ]
        end]
      end
    end

    # Evolve a single key selection with various types of values.
    #
    # @api private
    #
    # @example Evolve a simple selection.
    #   selector.evolve(field, 5)
    #
    # @param [ Object ] serializer The optional serializer for the field.
    # @param [ Object ] value The value to serialize.
    #
    # @return [ Object ] The serialized object.
    #
    # @since 1.0.0
    def evolve(serializer, value)
      case value
        when Hash then evolve_hash(serializer, value)
        when Array then evolve_array(serializer, value)
        else (serializer || value.class).evolve(value)
      end
    end

    # Evolve a single key selection with array values.
    #
    # @api private
    #
    # @example Evolve a simple selection.
    #   selector.evolve(field, [ 1, 2, 3 ])
    #
    # @param [ Object ] serializer The optional serializer for the field.
    # @param [ Array<Object> ] value The array to serialize.
    #
    # @return [ Object ] The serialized array.
    #
    # @since 1.0.0
    def evolve_array(serializer, value)
      value.map! do |_value|
        evolve(serializer, _value)
      end
    end

    # Evolve a single key selection with hash values.
    #
    # @api private
    #
    # @example Evolve a simple selection.
    #   selector.evolve(field, { "$gt" => 5 })
    #
    # @param [ Object ] serializer The optional serializer for the field.
    # @param [ Hash ] value The hash to serialize.
    #
    # @return [ Object ] The serialized hash.
    #
    # @since 1.0.0
    def evolve_hash(serializer, value)
      value.each_pair do |operator, _value|
        value[operator] = evolve(serializer, _value)
      end
    end

    # Determines if the selection is a multi-select, like an $and or $or
    # selection.
    #
    # @api private
    #
    # @example Is the selection a multi-select?
    #   selector.multi_selection?("$and")
    #
    # @param [ String ] key The key to check.
    #
    # @return [ true, false ] If the key is for a multi-select.
    #
    # @since 1.0.0
    def multi_selection?(key)
      key =~ /\$and|\$or/
    end

    # Get the normalized value for the key. If localization is in play the
    # current locale will be appended to the key in MongoDB dot notation.
    #
    # @api private
    #
    # @example Get the normalized key name.
    #   selector.normalized_key("field", serializer)
    #
    # @param [ String ] name The name of the field.
    # @param [ Object ] serializer The optional field serializer.
    #
    # @return [ String ] The normalized key.
    #
    # @since 1.0.0
    def normalized_key(name, serializer)
      serializer && serializer.localized? ? "#{name}.#{::I18n.locale}" : name
    end
  end
end
