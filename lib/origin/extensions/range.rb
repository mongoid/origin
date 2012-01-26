# encoding: utf-8
module Origin
  module Extensions
    module Range
      module ClassMethods

        def evolve(object)
          return object unless object.is_a?(::Range)
          { "$gte" => object.min, "$lte" => object.max }
        end
      end
    end
  end
end

::Range.__send__(:extend, Origin::Extensions::Range::ClassMethods)
