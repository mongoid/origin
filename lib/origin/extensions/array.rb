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
    end
  end
end
