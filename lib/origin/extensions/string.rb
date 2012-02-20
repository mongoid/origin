# encoding: utf-8
module Origin
  module Extensions
    module String

      def as_sorting_options
        split(/,/).inject({}) do |hash, spec|
          hash.tap do |_hash|
            field, direction = spec.strip.split(/\s/)
            _hash[field.to_sym] = direction.to_direction
          end
        end
      end

      def to_direction
        self =~ /desc/i ? -1 : 1
      end
    end
  end
end

::String.__send__(:include, Origin::Extensions::String)
