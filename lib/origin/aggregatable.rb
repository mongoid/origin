require "origin/aggregator"

module Origin
  module Aggregatable

    attr_accessor :aggregator

    def project(projection)
      params = ProjectParams.new(projection)

      clone.tap do
        aggregator.project.merge! params.hash
      end
    end

    def initialize
      @aggregator = Aggregator.new
    end


    class ProjectParams
      attr_reader :hash

      def initialize(*params)
        @hash = {}

        first = params.first
        hash = transform_array(first) || transform_hash(first) || {}

        hash.each_pair do |k, v|
          @hash[k.to_s] = v
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
    end
  end


end
