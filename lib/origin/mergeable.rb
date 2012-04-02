# encoding: utf-8
module Origin

  # Contains behaviour for merging existing selection with new selection.
  module Mergeable

    # @attribute [rw] strategy The name of the current strategy.
    attr_accessor :strategy

    # Instruct the next mergeable call to use intersection.
    #
    # @example Use intersection on the next call.
    #   mergeable.intersect.in(field: [ 1, 2, 3 ])
    #
    # @return [ Mergeable ] The intersect flagged mergeable.
    #
    # @since 1.0.0
    def intersect
      use(:__intersect__)
    end

    # Instruct the next mergeable call to use override.
    #
    # @example Use override on the next call.
    #   mergeable.override.in(field: [ 1, 2, 3 ])
    #
    # @return [ Mergeable ] The override flagged mergeable.
    #
    # @since 1.0.0
    def override
      use(:__override__)
    end

    # Instruct the next mergeable call to use union.
    #
    # @example Use union on the next call.
    #   mergeable.union.in(field: [ 1, 2, 3 ])
    #
    # @return [ Mergeable ] The union flagged mergeable.
    #
    # @since 1.0.0
    def union
      use(:__union__)
    end

    private

    # Adds the criterion to the existing selection.
    #
    # @api private
    #
    # @example Add the criterion.
    #   mergeable.__add__({ name: 1 }, "$in")
    #
    # @param [ Hash ] criterion The criteria.
    # @param [ String ] operator The MongoDB operator.
    #
    # @return [ Mergeable ] The new mergeable.
    #
    # @since 1.0.0
    def __add__(criterion, operator)
      with_strategy(:__add__, criterion, operator)
    end

    # Adds the criterion to the existing selection.
    #
    # @api private
    #
    # @example Add the criterion.
    #   mergeable.__expanded__([ 1, 10 ], "$within", "$center")
    #
    # @param [ Hash ] criterion The criteria.
    # @param [ String ] outer The outer MongoDB operator.
    # @param [ String ] inner The inner MongoDB operator.
    #
    # @return [ Mergeable ] The new mergeable.
    #
    # @since 1.0.0
    def __expanded__(criterion, outer, inner)
      selection(criterion) do |selector, field, value|
        selector.store(field, { outer => { inner => value }})
      end
    end

    # Adds the criterion to the existing selection.
    #
    # @api private
    #
    # @example Add the criterion.
    #   mergeable.__intersect__([ 1, 2 ], "$in")
    #
    # @param [ Hash ] criterion The criteria.
    # @param [ String ] operator The MongoDB operator.
    #
    # @return [ Mergeable ] The new mergeable.
    #
    # @since 1.0.0
    def __intersect__(criterion, operator)
      with_strategy(:__intersect__, criterion, operator)
    end

    # Adds the criterion to the existing selection.
    #
    # @api private
    #
    # @example Add the criterion.
    #   mergeable.__multi__([ 1, 2 ], "$in")
    #
    # @param [ Hash ] criterion The criteria.
    # @param [ String ] operator The MongoDB operator.
    #
    # @return [ Mergeable ] The new mergeable.
    #
    # @since 1.0.0
    def __multi__(criterion, operator)
      clone.tap do |query|
        sel = query.selector
        criterion.flatten.each do |expr|
          next unless expr
          criteria = sel[operator] || []
          normalized = expr.inject({}) do |hash, (field, value)|
            hash.merge!(field.specify(value))
            hash
          end
          sel.store(operator, criteria.push(normalized))
        end
      end
    end

    # Adds the criterion to the existing selection.
    #
    # @api private
    #
    # @example Add the criterion.
    #   mergeable.__override__([ 1, 2 ], "$in")
    #
    # @param [ Hash ] criterion The criteria.
    # @param [ String ] operator The MongoDB operator.
    #
    # @return [ Mergeable ] The new mergeable.
    #
    # @since 1.0.0
    def __override__(criterion, operator)
      selection(criterion) do |selector, field, value|
        selector.store(field, { operator => prepare(field, operator, value) })
      end
    end

    # Adds the criterion to the existing selection.
    #
    # @api private
    #
    # @example Add the criterion.
    #   mergeable.__union__([ 1, 2 ], "$in")
    #
    # @param [ Hash ] criterion The criteria.
    # @param [ String ] operator The MongoDB operator.
    #
    # @return [ Mergeable ] The new mergeable.
    #
    # @since 1.0.0
    def __union__(criterion, operator)
      with_strategy(:__union__, criterion, operator)
    end

    # Prepare the value for merging.
    #
    # @api private
    #
    # @example Prepare the value.
    #   mergeable.prepare("field", 10)
    #
    # @param [ String ] field The name of the field.
    # @param [ Object ] value The value.
    #
    # @return [ Object ] The serialized value.
    #
    # @since 1.0.0
    def prepare(field, operator, value)
      return value if operator =~ /exists|type|size/
      serializer = serializers[field]
      serializer ? serializer.evolve(value) : value
    end

    # Use the named strategy for the next operation.
    #
    # @api private
    #
    # @example Use intersection.
    #   mergeable.use(:__intersect__)
    #
    # @param [ Symbol ] strategy The strategy to use.
    #
    # @return [ Mergeable ] The existing mergeable.
    #
    # @since 1.0.0
    def use(strategy)
      tap do |mergeable|
        mergeable.strategy = strategy
      end
    end

    # Add criterion to the selection with the named strategy.
    #
    # @api private
    #
    # @example Add criterion with a strategy.
    #   selectable.with_strategy(:__union__, [ 1, 2, 3 ], "$in")
    #
    # @param [ Symbol ] strategy The name of the strategy method.
    # @param [ Object ] criterion The criterion to add.
    # @param [ String ] operator The MongoDB operator.
    #
    # @return [ Mergeable ] The cloned query.
    #
    # @since 1.0.0
    def with_strategy(strategy, criterion, operator)
      selection(criterion) do |selector, field, value|
        selector.store(
          field,
          selector[field].send(strategy, { operator => prepare(field, operator, value) })
        )
      end
    end
  end
end
