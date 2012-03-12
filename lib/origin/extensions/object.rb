# encoding: utf-8
module Origin
  module Extensions
    module Object

      def __add__(object)
        object == self ? self : [ self, object ].flatten.uniq
      end

      def __add_from_array__(array)
        array.concat(Array(self)).uniq
      end

      def __intersect__(object)
        object.__intersect_from_object__(self)
      end

      def __intersect_from_array__(array)
        array & Array(self)
      end

      def __intersect_from_object__(object)
        Array(object) & Array(self)
      end

      def __union__(object)
        object.__union_from_object__(self)
      end

      def __union_from_object__(object)
        (Array(object) + Array(self)).uniq
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

        def __evolve__(object)
          if object.is_a?(::Array)
            object.map!{ |obj| evolve(obj) }
          else
            yield(object)
          end
        end

        def __numeric__(object)
          object.to_s =~ /(^[-+]?[0-9]+$)|(\.0+)$/ ? object.to_i : Float(object)
        end
      end
    end
  end
end

::Object.__send__(:include, Origin::Extensions::Object)
::Object.__send__(:extend, Origin::Extensions::Object::ClassMethods)
