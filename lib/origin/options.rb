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
      super(key, evolve(value))
    end
    alias :[]= :store

    private

    # Evolve a single key selection with various types of values.
    #
    # @api private
    #
    # @example Evolve a simple selection.
    #   options.evolve(field, 5)
    #
    # @param [ Object ] value The value to serialize.
    #
    # @return [ Object ] The serialized object.
    #
    # @since 1.0.0
    def evolve(value)
      case value
      when Hash
        evolve_hash(value)
      else
        value
      end
    end

    # Evolve a single key selection with hash values.
    #
    # @api private
    #
    # @example Evolve a simple selection.
    #   options.evolve(field, { "$gt" => 5 })
    #
    # @param [ Hash ] value The hash to serialize.
    #
    # @return [ Object ] The serialized hash.
    #
    # @since 1.0.0
    def evolve_hash(value)
      value.inject({}) do |hash, (field, _value)|
        name, serializer = storage_pair(field)
        hash[normalized_key(name, serializer)] = _value
        hash
      end
    end
  end
end
