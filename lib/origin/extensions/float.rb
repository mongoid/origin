# encoding: utf-8
module Origin
  module Extensions
    module Float
      module ClassMethods

        def evolve(object)
          __numeric__(object) rescue object
        end
      end
    end
  end
end

::Float.__send__(:extend, Origin::Extensions::Float::ClassMethods)
