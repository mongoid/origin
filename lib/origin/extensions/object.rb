# encoding: utf-8
module Origin
  module Extensions
    module Object

      def __add__(object)
        object == self ? self : [ self, object ].flatten.uniq
      end

      def __intersect__(object)
        if object.is_a?(Hash)
          object[object.keys.first] = __intersect__(object.values.first)
          object
        else
          Array(self) & Array(object)
        end
      end

      def __union__(object)
        if object.is_a?(Hash)
          object[object.keys.first] = __union__(object.values.first)
          object
        else
          (Array(self) + Array(object)).uniq
        end
      end

      def __deep_copy__
        self
      end

      def as_array
        [ self ]
      end

      module ClassMethods

        def evolve(object)
          object
        end

        private

        def __numeric__(object)
          object.to_s =~ /(^[-+]?[0-9]+$)|(\.0+)$/ ? object.to_i : Float(object)
        end
      end
    end
  end
end

::Object.__send__(:include, Origin::Extensions::Object)
::Object.__send__(:extend, Origin::Extensions::Object::ClassMethods)
