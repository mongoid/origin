# encoding: utf-8
module Origin
  module Extensions

    # This module contains additional nil behaviour.
    module NilClass

      # Add this object to nil.
      #
      # @example Add the object to a nil value.
      #   nil.__add__([ 1, 2, 3 ])
      #
      # @param [ Object ] object The object to add.
      #
      # @return [ Object ] The provided object.
      #
      # @since 1.0.0
      def __add__(object); object; end

      # Add this object to nil.
      #
      # @example Add the object to a nil value.
      #   nil.__intersect__([ 1, 2, 3 ])
      #
      # @param [ Object ] object The object to intersect.
      #
      # @return [ Object ] The provided object.
      #
      # @since 1.0.0
      def __intersect__(object); object; end

      # Add this object to nil.
      #
      # @example Add the object to a nil value.
      #   nil.__union__([ 1, 2, 3 ])
      #
      # @param [ Object ] object The object to union.
      #
      # @return [ Object ] The provided object.
      #
      # @since 1.0.0
      def __union__(object); object; end
    end
  end
end

::NilClass.__send__(:include, Origin::Extensions::NilClass)
