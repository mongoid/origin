module Origin

  module Aggregatable

    class Sort < Operation

      def name
        "$sort"
      end

      def initialize(*args)
        @operator = with_hash(*args) || with_array(*args) || with_string(*args) || with_symbol(*args)
      end

      private
      def with_hash(*args)
        return unless args.first.is_a?(Hash)

        evolve_hash args.first
      end

      def with_array(*args)
        return unless args.first.is_a?(Array)

        {}.tap do |operator|
          args.first.each do |f|
            operator[f.to_s] = 1
          end
        end
      end

      def with_string(*args)
        return unless args.first.is_a?(String)

        { args.first => 1 }
      end

      def with_symbol(*args)
        return unless args.first.is_a?(Symbol)

        { args.first.to_s => 1 }
      end

      def evolve_hash(hash)
        {}.tap do |h|
          hash.each_pair do |k,v|
            h[k.to_s] = evolve_value(v)
          end
        end
      end

      def evolve_value(value)
        return value if value.is_a?(Fixnum)

        return 1 if value == :asc
        return -1 if value == :desc
      end

    end

  end

end
