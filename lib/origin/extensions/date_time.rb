# encoding: utf-8
module Origin
  module Extensions

    # This module contains additional datetime behaviour.
    module DateTime

      def __evolve_time__
        ::Time.local(year, month, day, hour, min, sec)
      end

      module ClassMethods

        # Evolve the object to an date.
        #
        # @example Evolve dates.
        #
        # @example Evolve string dates.
        #
        # @example Evolve date ranges.
        #
        # @param [ Object ] object The object to evolve.
        #
        # @return [ Time ] The evolved date time.
        #
        # @since 1.0.0
        def evolve(object)
          object.__evolve_time__
        end
      end
    end
  end
end

::DateTime.__send__(:include, Origin::Extensions::DateTime)
::DateTime.__send__(:extend, Origin::Extensions::DateTime::ClassMethods)
