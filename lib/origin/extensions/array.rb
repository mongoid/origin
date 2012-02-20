# encoding: utf-8
module Origin
  module Extensions
    module Array

      def __add__(object)
        if object.is_a?(Hash)
          object[object.keys.first] = __add__(object.values.first)
          object
        else
          concat(Array(object)).uniq
        end
      end

      def __intersect__(object)
        if object.is_a?(Hash)
          object[object.keys.first] = __intersect__(object.values.first)
          object
        else
          self & Array(object)
        end
      end

      def __deep_copy__
        [].tap do |copy|
          each do |value|
            copy.push(value.__deep_copy__)
          end
        end
      end

      def as_sorting_options
        case first
        when Selectable::Key
          inject({}) do |hash, value|
            hash.tap { |_hash| _hash.merge!(value.as_sorting_options) }
          end
        when Array
          ::Hash[self]
        else
          ::Hash[[ self ]]
        end
      end
    end
  end
end

::Array.__send__(:include, Origin::Extensions::Array)
