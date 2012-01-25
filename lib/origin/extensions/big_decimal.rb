# encoding: utf-8
require "bigdecimal"

module Origin
  module Extensions
    module BigDecimal
      module ClassMethods

        def evolve(object)
          return object unless object
          object.to_s
        end
      end
    end
  end
end

::BigDecimal.__send__(:extend, Origin::Extensions::BigDecimal::ClassMethods)
