require "origin/aggregator"
require "origin/aggregatable/operation"
require "origin/aggregatable/project"
require "origin/aggregatable/match"
require "origin/aggregatable/limit"
require "origin/aggregatable/skip"
require "origin/aggregatable/unwind"
require "origin/aggregatable/group"
require "origin/aggregatable/sort"

module Origin
  module Aggregatable

    attr_reader :aggregator

    def project(projection)
      return clone unless projection

      clone.tap do
        aggregator << Project.new(projection)
      end
    end

    def match(match)
      return clone unless match

      clone.tap do
        aggregator << Match.new(match)
      end
    end

    def limit(limit)
      return clone unless limit

      clone.tap do
        aggregator << Limit.new(limit)
      end
    end

    def skip(skip)
      return clone unless skip

      clone.tap do
        aggregator << Skip.new(skip)
      end
    end

    def unwind(unwind)
      return clone unless unwind

      clone.tap do
        aggregator << Unwind.new(unwind)
      end
    end

    def group(group)
      return clone unless group

      clone.tap do
        aggregator << Group.new(group)
      end
    end

    def sort(sort)
      return clone unless sort

      clone.tap do
        aggregator << Sort.new(sort)
      end
    end

    def initialize
      @aggregator = Aggregator.new
    end

  end
end
