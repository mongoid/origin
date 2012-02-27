# encoding: utf-8
require "origin/extensions"
require "origin/optional"
require "origin/options"
require "origin/selectable"
require "origin/selector"

module Origin
  module Queryable
    include Selectable
    include Optional

    def ==(other)
      return false unless other.is_a?(Queryable)
      selector == other.selector &&
        options == other.options
    end

    def initialize
      @options, @selector = Options.new, Selector.new
      yield(self) if block_given?
    end

    def initialize_copy(other)
      @options = other.options.__deep_copy__
      @selector = other.selector.__deep_copy__
    end
  end
end
