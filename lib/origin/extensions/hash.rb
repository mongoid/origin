# encoding: utf-8
module Origin
  module Extensions
    module Hash

      def __add__(object)
        apply_strategy(:__add__, object)
      end

      def __intersect__(object)
        apply_strategy(:__intersect__, object)
      end

      def __union__(object)
        apply_strategy(:__union__, object)
      end

      def __deep_copy__
        {}.tap do |copy|
          each_pair do |key, value|
            copy.store(key, value.__deep_copy__)
          end
        end
      end

      def as_sorting_options
        tap do |hash|
          hash.each_pair do |key, value|
            hash.store(key, value.to_direction)
          end
        end
      end

      private

      def apply_strategy(strategy, object)
        tap do |hash|
          object.each_pair do |key, value|
            hash.store(key, hash[key].send(strategy, value))
          end
        end
      end
    end
  end
end

::Hash.__send__(:include, Origin::Extensions::Hash)
