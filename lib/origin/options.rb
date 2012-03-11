# encoding: utf-8
module Origin

  # The options is a hash representation of options passed to MongoDB queries,
  # such as skip, limit, and sorting criteria.
  class Options < Smash

    # Store the value in the options for the provided key. The options will
    # handle all necessary serialization and localization in this step.
    #
    # @example Store a value in the options.
    #   options.store(:key, "testing")
    #
    # @param [ String, Symbol ] key The name of the attribute.
    # @param [ Object ] value The value to add.
    #
    # @return [ Object ] The stored object.
    #
    # @since 1.0.0
    def store(key, value)
      name, serializer = storage_pair(key)
      super(name.to_s, evolve(serializer, value))
    end
    alias :[]= :store

    private

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
      when Hash
        evolve_hash(serializer, value)
      else
        value
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
      value.inject({}) do |hash, (field, _value)|
        hash[normalized_key(field.to_s, serializer)] = _value
        hash
      end
    end
  end
end
