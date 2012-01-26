# encoding: utf-8
module Origin
  module Extensions
    module Set
      module ClassMethods

        def evolve(object)
          return object unless object
          object.respond_to?(:to_a) ? object.to_a : object
        end
      end
    end
  end
end

::Set.__send__(:extend, Origin::Extensions::Set::ClassMethods)
