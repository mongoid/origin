# encoding: utf-8
module Origin
  module Extensions

    # This module contains additional integer behaviour.
    module Integer

      def __evolve_time__
        ::Time.at(self)
      end

      # Get the integer as a sort direction.
      #
      # @example Get the integer as a sort direction.
      #   1.to_direction
      #
      # @return [ Integer ] self.
      #
      # @since 1.0.0
      def to_direction; self; end

      module ClassMethods

        # Evolve the object to an integer.
        #
        # @example Evolve to integers.
        #   Integer.evolve("1")
        #
        # @param [ Object ] object The object to evolve.
        #
        # @return [ Integer ] The evolved object.
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

::Integer.__send__(:include, Origin::Extensions::Integer)
::Integer.__send__(:extend, Origin::Extensions::Integer::ClassMethods)
