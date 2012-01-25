# encoding: utf-8
require "bigdecimal"

module Origin
  module Extensions
    module BigDecimal
      module ClassMethods

        def evolve(object)
          object.to_s
        end
      end
    end
  end
end
