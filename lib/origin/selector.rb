# encoding: utf-8
module Origin

  # The selector is a special kind of hash that knows how to serialize values
  # coming into it as well as being alias and locale aware for key names.
  class Selector < Hash

    # @attribute [r] serializers The serializers.
    attr_reader :serializers

    # Initialize the new selector.
    #
    # @example Initialize the new selector.
    #   Origin::Selector.new(serializers)
    #
    # @param [ Hash ] serializers An optional hash of objects that are
    #   responsible for serializing values. The keys of the hash must be
    #   strings that match the field name, and the values must respond to
    #   #localized? and #evolve(object).
    #
    # @since 1.0.0
    def initialize(serializers = nil)
      @serializers = serializers || {}
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
      name = key.to_s
      serializer = serializers[name]
      if multi_selection?(name)
        super(name, evolve_multi(value))
      else
        super(normalized_key(name, serializer), evolve(serializer, value))
      end
    end
    alias :[]= :store

    private

    # @api private
    def evolve_multi(value)
      value.map do |val|
        Hash[val.map do |key, _value|
          name = key.to_s
          serializer = serializers[name]
          [ normalized_key(name, serializer), evolve(serializer, _value) ]
        end]
      end
    end

    # @api private
    def evolve(serializer, value)
      case value
        when Hash then evolve_hash(serializer, value)
        when Array then evolve_array(serializer, value)
        else (serializer || value.class).evolve(value)
      end
    end

    # @api private
    def evolve_array(serializer, value)
      value.map do |_value|
        evolve(serializer, _value)
      end
    end

    # @api private
    def evolve_hash(serializer, value)
      value.reduce({}) do |hash, (operator, _value)|
        hash[operator] = evolve(serializer, _value)
        hash
      end
    end

    # @api private
    def multi_selection?(key)
      key =~ /\$and|\$or/
    end

    # @api private
    def normalized_key(name, serializer)
      serializer && serializer.localized? ? "#{name}.#{::I18n.locale}" : name
    end
  end
end
