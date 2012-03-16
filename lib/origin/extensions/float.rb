# encoding: utf-8
module Origin
  module Extensions

    # This module contains behaviour extensions for floats.
    module Float

      def __evolve_time__
        ::Time.at(self)
      end

      module ClassMethods

        # Evolve the object into a float for selection.
        #
        # @example Evolve the object to a float.
        #   Float.evolve("2.34")
        #
        # @param [ Object ] object The object to evolve.
        #
        # @return [ Float ] The evolved float.
        #
        # @since 1.0.0
        def evolve(object)
          __evolve__(object) do |obj|
            __numeric__(obj) rescue obj
          end
        end
      end
    end
  end
end

::Float.__send__(:include, Origin::Extensions::Float)
::Float.__send__(:extend, Origin::Extensions::Float::ClassMethods)
