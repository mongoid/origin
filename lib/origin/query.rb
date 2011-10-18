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

    def initialize_copy(other)
      @selector = other.selector.dup
    end
  end
end
