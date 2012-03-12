# encoding: utf-8
module Origin
  module Extensions
    module Set
      module ClassMethods

        def evolve(object)
          return object if !object || !object.respond_to?(:map)
          object.map{ |obj| obj.class.evolve(obj) }
        end
      end
    end
  end
end

::Set.__send__(:extend, Origin::Extensions::Set::ClassMethods)
