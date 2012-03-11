# encoding: utf-8
module Origin
  module Selectable

    # Contains behaviour for adding $all selection.
    module All

      # Add the $all criterion.
      #
      # @example Add the criterion.
      #   queryable.all(field: [ 1, 2 ])
      #
      # @example Execute an $all in a where query.
      #   queryable.where(:field.all => [ 1, 2 ])
      #
      # @param [ Hash ] criterion The key value pairs for $all matching.
      #
      # @return [ Queryable ] The cloned queryable.
      #
      # @since 1.0.0
      def all(criterion = nil)
        send(strategy || :__override__, with_array_values(criterion), "$all")
      end
      alias :all_in :all
        
      ::Symbol.add_key(:all, "$all")
    end
  end
end
