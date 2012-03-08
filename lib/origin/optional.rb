# encoding: utf-8
require "origin/optional/ascending"
require "origin/optional/batch_size"
require "origin/optional/descending"
require "origin/optional/limit"
require "origin/optional/max_scan"
require "origin/optional/no_timeout"
require "origin/optional/only"
require "origin/optional/order_by"
require "origin/optional/skip"
require "origin/optional/slice"
require "origin/optional/snapshot"
require "origin/optional/without"

module Origin

  # The optional module includes all behaviour that has to do with extra
  # options surrounding queries, like skip, limit, sorting, etc.
  module Optional
    include Ascending
    include BatchSize
    include Descending
    include Limit
    include MaxScan
    include NoTimeout
    include Only
    include OrderBy
    include Skip
    include Slice
    include Snapshot
    include Without

    # @attribute [rw] options The query options.
    attr_accessor :options

    # Take the provided criterion and store it as an option in the query
    # options.
    #
    # @example Store the option.
    #   optional.option({ skip: 10 })
    #
    # @param [ Array ] args The options.
    #
    # @return [ Queryable ] The cloned queryable.
    #
    # @since 1.0.0
    def option(*args)
      clone.tap do |query|
        unless args.compact.empty?
          yield(query.options)
        end
      end
    end
  end
end
