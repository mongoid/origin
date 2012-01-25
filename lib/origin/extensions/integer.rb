# encoding: utf-8
module Origin
  module Extensions
    module Integer
      module ClassMethods

        def evolve(object)
          __numeric__(object) rescue object
        end
      end
    end
  end
end

::Integer.__send__(:extend, Origin::Extensions::Integer::ClassMethods)
