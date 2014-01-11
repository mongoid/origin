# encoding: utf-8
require "origin/extensions"
require "origin/key"
require "origin/macroable"
require "origin/mergeable"
require "origin/smash"
require "origin/aggregable"
require "origin/pipeline"
require "origin/optional"
require "origin/options"
require "origin/selectable"
require "origin/selector"

module Origin

  # A queryable is any object that needs origin's dsl injected into it to build
  # MongoDB queries. For example, a Mongoid::Criteria is an Origin::Queryable.
  #
  # @example Include queryable functionality.
  #   class Criteria
  #     include Origin::Queryable
  #   end
  module Queryable
    include Mergeable
    include Aggregable
    include Selectable
    include Optional

    # @attribute [r] aliases The aliases.
    # @attribute [r] driver The Mongo driver being used.
    # @attribute [r] serializers The serializers.
    attr_reader :aliases, :driver, :serializers

    # Is this queryable equal to another object? Is true if the selector and
    # options are equal.
    #
    # @example Are the objects equal?
    #   queryable == criteria
    #
    # @param [ Object ] other The object to compare against.
    #
    # @return [ true, false ] If the objects are equal.
    #
    # @since 1.0.0
    def ==(other)
      return false unless other.is_a?(Queryable)
      selector == other.selector && options == other.options
    end

    # Initialize the new queryable. Will yield itself to the block if a block
    # is provided for objects that need additional behaviour.
    #
    # @example Initialize the queryable.
    #   Origin::Queryable.new
    #
    # @param [ Hash ] aliases The optional field aliases.
    # @param [ Hash ] serializers The optional field serializers.
    # @param [ Symbol ] driver The driver being used.
    #
    # @since 1.0.0
    def initialize(aliases = {}, serializers = {}, driver = :moped)
      @aliases, @driver, @serializers = aliases, driver.to_sym, serializers
      @options = Options.new(aliases, serializers)
      @selector = Selector.new(aliases, serializers)
      @pipeline = Pipeline.new(aliases)
      yield(self) if block_given?
    end

    # Handle the creation of a copy via #clone or #dup.
    #
    # @example Handle copy initialization.
    #   queryable.initialize_copy(criteria)
    #
    # @param [ Queryable ] other The original copy.
    #
    # @since 1.0.0
    def initialize_copy(other)
      @options = other.options.__deep_copy__
      @selector = other.selector.__deep_copy__
      @pipeline = other.pipeline.__deep_copy__
    end

    # Raised when ActionController::Parameters are passed directly or as a
    # value to a selection. This is a security measure to ensure users
    # explicity build their own hashes to pass to query methods.
    #
    # @see https://jira.mongodb.org/browse/SECURITY-90
    #
    # @since 2.2.0
    class Insecure < RuntimeError

      # @attribute [r] selection The bad selection.
      attr_reader :selection

      # Create the new insecure exception.
      #
      # @example Create the new exception.
      #   Insecure.new(email: "testing")
      #
      # @param [ ActionController::Parameters ] selection The selction direct
      #   from the params.
      #
      # @since 2.2.0
      def initialize(selection)
        @selection = selection
        super(
          "Passing the request parameters #{selection} directly into criteria " +
          "is insecure. If you meant to do this please call #to_hash on the " +
          "parameters to get the raw selection."
        )
      end
    end

    private

    # Check if the value is secure (not passed directly from the request
    # parameters).
    #
    # @api private
    #
    # @example Check the value's security.
    #   selectable.check_security!(email: "testing")
    #
    # @param [ Object ] value The value to check.
    #
    # @raise [ Insecure ] If the value is params.
    #
    # @since 2.2.0
    def check_security!(value)
      raise Insecure.new(value) if value.is_a?(ActionController::Parameters)
    end
  end
end
