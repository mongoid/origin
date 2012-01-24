# encoding: utf-8
module Origin
  class Selector < Hash

    attr_reader :serializers

    def []=(key, value)
      super(key, serialize(key, value))
    end

    def initialize(serializers = nil)
      @serializers = serializers || {}
    end

    def store(key, value)
      super(key, serialize(key, value))
    end

    private

    def serialize(key, value)
      serializer = serializers[key]
      return value unless serializer
      serializer.selectionize(value)
    end
  end
end
