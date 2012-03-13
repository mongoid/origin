# encoding: utf-8
require "origin/selectable/all"
require "origin/selectable/and"
require "origin/selectable/between"
require "origin/selectable/elem_match"
require "origin/selectable/exists"
require "origin/selectable/gt"
require "origin/selectable/gte"
require "origin/selectable/in"
require "origin/selectable/key"
require "origin/selectable/lt"
require "origin/selectable/lte"
require "origin/selectable/max_distance"
require "origin/selectable/mod"
require "origin/selectable/ne"
require "origin/selectable/near"
require "origin/selectable/near_sphere"
require "origin/selectable/nin"
require "origin/selectable/nor"
require "origin/selectable/or"
require "origin/selectable/size"
require "origin/selectable/strategies"
require "origin/selectable/type"
require "origin/selectable/where"
require "origin/selectable/within_box"
require "origin/selectable/within_circle"
require "origin/selectable/within_polygon"
require "origin/selectable/within_spherical_circle"

module Origin

  # An origin queryable is selectable, in that it has the ability to select
  # document from the database. The selectable module brings all functionality
  # to the queryable that has to do with building MongoDB selectors.
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

    # @attribute [rw] selector The query selector.
    attr_accessor :selector

    # Take the provided criterion and store it as a selection in the query
    # selector.
    #
    # @example Store the selection.
    #   selectable.selection({ field: "value" })
    #
    # @param [ Hash ] criterion The selection to store.
    #
    # @return [ Queryable ] The cloned queryable.
    #
    # @since 1.0.0
    def selection(criterion = nil)
      clone.tap do |query|
        if criterion
          criterion.each_pair do |field, value|
            yield(query.selector, field.is_a?(Key) ? field : field.to_s, value)
          end
        end
      end
    end

    private

    # Convert the criterion values to $in friendly values. This means you,
    # array.
    #
    # @api private
    #
    # @example Convert all the values to arrays.
    #   queryable.with_array_values({ key: 1...4 })
    #
    # @param [ Hash ] criterion The criterion.
    #
    # @return [ Hash ] The $in friendly criterion (array values).
    #
    # @since 1.0.0
    def with_array_values(criterion)
      return nil unless criterion
      criterion.each_pair do |key, value|
        criterion[key] = value.__array__
      end
    end
  end
end
