# encoding: utf-8
module Origin
  module Extensions
    module Set
      module ClassMethods

        def evolve(object, type = nil)
          return object if !object || !object.respond_to?(:to_a)
          object.to_a.map!{ |obj| (type || obj.class).evolve(obj) }
        end
      end
    end
  end
end

::Set.__send__(:extend, Origin::Extensions::Set::ClassMethods)
