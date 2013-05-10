module Origin

  class Aggregator < Array

    alias_method :super_add, :<<

    def << (operation)
      return unless operation && operation.is_a?(Aggregatable::Operation)
      super_add( { operation.name => operation.operator } )
    end

  end
end
