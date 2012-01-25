# encoding: utf-8
module Origin
  module Extensions
    module Boolean
      module ClassMethods

        def evolve(object)
          return true if object.to_s =~ (/(true|t|yes|y|1|1.0)$/i)
          false
        end
      end
    end
  end
end

::Boolean.__send__(:extend, Origin::Extensions::Boolean::ClassMethods)
