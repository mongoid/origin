# encoding: utf-8
module Origin
  module Extensions

    # This module contains additional date behaviour.
    module Date

      module ClassMethods

        # Evolve the object to an date.
        #
        # @example Evolve dates.
        #   Date.evolve(Date.new(1990, 1, 1))
        #
        # @example Evolve string dates.
        #   Date.evolve("1990-1-1")
        #
        # @example Evolve date ranges.
        #   Date.evolve(Date.new(1990, 1, 1)..Date.new(1990, 1, 4))
        #
        # @param [ Object ] object The object to evolve.
        #
        # @return [ Time ] The evolved date.
        #
        # @since 1.0.0
        def evolve(object)
          __evolve__(object) do |obj|
            (obj.respond_to?(:to_time) ? obj : ::Date.parse(obj)).to_time
          end
        end
      end
    end
  end
end

::Date.__send__(:extend, Origin::Extensions::Date::ClassMethods)
