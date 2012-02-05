# encoding: utf-8
require "origin/extensions"
require "origin/selectable"
require "origin/selector"

module Origin
  module Queryable
    include Selectable

    attr_reader :selector

    def ==(other)
      return false unless other.is_a?(Queryable)
      selector == other.selector
    end

    def initialize
      @selector = Selector.new
      yield(self) if block_given?
    end

    def initialize_copy(other)
      @selector = other.selector.__deep_copy__
    end
  end
end
