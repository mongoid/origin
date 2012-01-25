# encoding: utf-8
module Origin
  class Selector < Hash

    attr_reader :serializers

    def initialize(serializers = nil)
      @serializers = serializers || {}
    end

    def store(key, value)
      if and_or_selection?(key)
        super(key, evolve_and_or(value))
      else
        super(key, evolve(serializers[key], value))
      end
    end
    alias :[]= :store

    private

    def and_or_selection?(key)
      [ "$and", "$or"].include?(key)
    end

    def evolve_and_or(value)
      value.map do |val|
        Hash[val.map do |_key, _value|
          [ _key, evolve(serializers[_key], _value) ]
        end]
      end
    end

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
