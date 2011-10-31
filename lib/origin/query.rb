# encoding: utf-8
require "origin/options"
require "origin/selector"

module Origin
  class Query
    include Optional
    include Selection

    attr_reader :options, :selector

    def ==(other)
      return false unless other.is_a?(Query)
      selector == other.selector && options == other.options
    end

    def initialize
      @options, @selector = Options.new, Selector.new
      yield(self) if block_given?
    end

    def initialize_copy(other)
      @options, @selector = other.options.dup, other.selector.dup
    end
  end
end
