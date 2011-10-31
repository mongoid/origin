# encoding: utf-8
require "origin/selection/strategies/add"
require "origin/selection/strategies/expanded"
require "origin/selection/strategies/intersect"
require "origin/selection/strategies/multi"
require "origin/selection/strategies/override"
require "origin/selection/strategies/union"

module Origin
  module Selection
    module Strategies
      include Add
      include Expanded
      include Intersect
      include Multi
      include Override
      include Union

      attr_accessor :strategy

      def selection(criterion = nil)
        clone.tap do |query|
          if criterion
            criterion.each_pair do |field, value|
              yield(query.selector, field, value)
            end
          end
        end
      end

      def option(*args)
        clone.tap do |query|
          unless args.compact.empty?
            yield(query.options)
          end
        end
      end
    end
  end
end
