# encoding: utf-8
require "origin/selection/strategies/override"

module Origin
  module Selection
    module Strategies
      # include Intersection
      include Override
      # include Union

      def assimilate(criterion = nil)
        clone.tap do |query|
          if criterion
            criterion.each_pair do |field, value|
              yield(query, field, value)
            end
          end
        end
      end
    end
  end
end
