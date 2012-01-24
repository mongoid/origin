# encoding: utf-8
module Origin
  class Selector < Hash

    attr_reader :serializers

    def []=(key, value)
      super(key, evolve(serializers[key], value))
    end

    def initialize(serializers = nil)
      @serializers = serializers || {}
    end

    def store(key, value)
      super(key, evolve(serializers[key], value))
    end

    private

    def evolve(serializer, value)
      return value unless serializer
      case value
        when Hash then evolve_hash(serializer, value)
        when Array then evolve_array(serializer, value)
        else serializer.evolve(value)
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
