module Origin
  module Aggregatable
    class ProjectParams
      attr_reader :hash

      def initialize(*params)
        @hash = {}

        first = params.first
        hash = transform_array(first) || transform_hash(first) || {}

        hash.each_pair do |k, v|
          @hash[k.to_s] = transform_val(v)
        end
      end

      private
      def transform_array(array)
        return nil unless array.is_a?(Array)

        hash = {}
        array.each do |f|
          hash[f] = 1
        end

        hash
      end

      def transform_hash(hash)
        return nil unless hash.is_a?(Hash)

        hash
      end

      def transform_val(v)
        return 1 if v == true
        return 0 if v == false

        v
      end

    end
  end
end
