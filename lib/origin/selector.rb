# encoding: utf-8
module Origin
  class Selector < Hash

    attr_reader :serializers

    def initialize(serializers = nil)
      @serializers = serializers || {}
    end

    def store(key, value)
      # @todo: Durran: Handle aliased fields here.
      normalized = key.to_s
      if multi_selection?(normalized)
        super(normalized, evolve_multi(value))
      else
        super(normalized, evolve(serializers[normalized], value))
      end
    end
    alias :[]= :store

    private

    def multi_selection?(key)
      key =~ /\$and|\$or/
    end

    def evolve_multi(value)
      value.map do |val|
        Hash[val.map do |_key, _value|
          normalized = _key.to_s
          [ normalized, evolve(serializers[normalized], _value) ]
        end]
      end
    end

    def evolve(serializer, value)
      case value
        when Hash then evolve_hash(serializer, value)
        when Array then evolve_array(serializer, value)
        else (serializer || value.class).evolve(value)
      end
    end

    def evolve_array(serializer, value)
      value.map do |_value|
        evolve(serializer, _value)
      end
    end

    def evolve_hash(serializer, value)
      value.reduce({}) do |hash, (operator, _value)|
        hash[operator] = evolve(serializer, _value)
        hash
      end
    end
  end
end
