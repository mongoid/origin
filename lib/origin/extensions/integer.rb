# encoding: utf-8
module Origin
  module Extensions
    module Integer

      def to_direction; self; end

      module ClassMethods

        def evolve(object)
          __numeric__(object) rescue object
        end
      end
    end
  end
end

::Integer.__send__(:include, Origin::Extensions::Integer)
::Integer.__send__(:extend, Origin::Extensions::Integer::ClassMethods)
