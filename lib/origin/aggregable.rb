# encoding: utf-8
module Origin

  # Provides a DSL around crafting aggregation framework commands.
  #
  # @since 2.0.0
  module Aggregable

    # @attribute [r] pipeline The aggregation pipeline.
    attr_reader :pipeline

    # @attribute [rw] aggregating Flag for whether or not we are aggregating.
    attr_writer :aggregating

    # Has the aggregable enter an aggregation state. Ie, are only aggregation
    # operations allowed at this point on.
    #
    # @example Is the aggregable aggregating?
    #   aggregable.aggregating?
    #
    # @return [ true, false ] If the aggregable is aggregating.
    #
    # @since 2.0.0
    def aggregating?
      !!@aggregating
    end

    def group(criterion)
      aggregation(criterion) do |pipeline, operation|
        pipeline.push("$group" => operation)
      end
    end

    # Add a projection to the aggregation pipeline.
    #
    # @example Add a projection to the pipeline.
    #   aggregable.project(author: 1, name: 0)
    #
    # @param [ Hash ] criterion The projection to make.
    #
    # @return [ Aggregable ] The aggregable.
    #
    # @since 2.0.0
    def project(criterion)
      aggregation(criterion) do |pipeline, operation|
        pipeline.push("$project" => operation)
      end
    end

    def unwind(criterion)
      aggregation(criterion) do |pipeline, operation|
        pipeline.push("$unwind" => operation)
      end
    end

    private

    # Add the aggregation operation.
    #
    # @api private
    #
    # @example Aggregate on the operation.
    #   aggregation(name: 1) do |pipeline, operation|
    #     pipeline.push("$project" => operation)
    #   end
    #
    # @param [ Hash ] criterion The criterion for the pipeline.
    #
    # @return [ Aggregable ] The cloned aggregable.
    #
    # @since 2.0.0
    def aggregation(criterion)
      clone.tap do |query|
        unless aggregating?
          query.pipeline.concat(query.selector.to_pipeline)
          query.pipeline.concat(query.options.to_pipeline)
          query.aggregating = true
        end
        yield(query.pipeline, evolve_aggregation(criterion))
      end
    end

    # Evolve the aggregation, so that we can handle aliased fields, and
    # serialization.
    #
    # @api private
    #
    # @example Evolve the aggregation.
    #   qggregable.evolve_aggregation(name: 1)
    #
    # @param [ Hash ] criterion The operation to evolve.
    #
    # @return [ Hash ] The evolved aggregation.
    #
    # @since 2.0.0
    def evolve_aggregation(criterion)
      aggregate = Selector.new(aliases)
      criterion.each_pair do |field, value|
        aggregate.merge!(field.to_s => value)
      end
      aggregate
    end
  end
end
