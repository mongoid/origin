require "origin/aggregator"

module Origin
  module Aggregatable

    attr_accessor :aggregator

    def project(projection)
      clone.tap do |aggretable|
        aggregator["$project"] = {} unless aggregator["$project"]

        projection.each_pair do |key, val|
          aggregator["$project"].merge!( { key.to_s => val } )
        end

      end
    end

    def initialize
      @aggregator = Aggregator.new
    end

  end
end