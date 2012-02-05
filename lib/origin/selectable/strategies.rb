# encoding: utf-8
require "origin/selectable/strategies/add"
require "origin/selectable/strategies/expanded"
require "origin/selectable/strategies/intersect"
require "origin/selectable/strategies/multi"
require "origin/selectable/strategies/override"
require "origin/selectable/strategies/union"

module Origin
  module Selectable
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
