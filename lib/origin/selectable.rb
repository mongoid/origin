# encoding: utf-8
require_all __FILE__, "selectable"

module Origin
  module Selectable
    include Strategies

    include All
    include And
    include Between
    include ElemMatch
    include Exists
    include Gt
    include Gte
    include In
    include Lt
    include Lte
    include MaxDistance
    include Mod
    include Ne
    include Near
    include NearSphere
    include Nin
    include Nor
    include Or
    include Size
    include Type
    include Where
    include WithinBox
    include WithinCircle
    include WithinPolygon
    include WithinSphericalCircle

    attr_reader :selector

    def selection(criterion = nil)
      clone.tap do |query|
        if criterion
          criterion.each_pair do |field, value|
            yield(query.selector, field, value)
          end
        end
      end
    end
  end
end
