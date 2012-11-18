require "origin/aggregator"

module Origin
  module Aggregatable

    attr_reader :aggregator

    def project(projection)
      return clone unless projection

      params = ProjectParams.new(projection)

      clone.tap do
        aggregator.project params.hash
      end
    end

    def limit(limit)
      clone.tap do
        aggregator.limit limit
      end
    end

    def skip(skip)
      clone.tap do
        aggregator.skip skip
      end
    end

    def unwind(unwind)
      clone.tap do
        aggregator.unwind unwind
      end
    end

    def initialize
      @aggregator = Aggregator.new
    end

  end
end
