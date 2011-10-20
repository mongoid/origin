# encoding: utf-8
require "origin/selector"

module Origin
  class Query
    # include Option::Explain
    # include Option::Hint
    # include Option::Only
    # include Option::OrderBy
    # include Option::Slice
    # include Option::Without
    include Selection

    attr_reader :selector

    def ==(other)
      return false unless other.is_a?(Query)
      selector == other.selector
    end

    def initialize
      @selector = Selector.new
      yield(self) if block_given?
    end

    private

    def assimilate(criterion = nil)
      clone.tap do |query|
        if criterion
          criterion.each_pair do |field, value|
            yield(query, field, value)
          end
        end
      end
    end

    def initialize_copy(other)
      @selector = other.selector.dup
    end
  end
end
