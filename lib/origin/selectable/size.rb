# encoding: utf-8
module Origin
  module Selectable

    # Provides behaviour for $size selection.
    module Size

      # Add a $size selection for array fields.
      #
      # @example Add the $size selection.
      #   queryable.with_size(field: 5)
      #
      # @note This method is named #with_size not to conflict with any existing
      #   #size method on enumerables or symbols.
      #
      # @example Execute an $size in a where query.
      #   queryable.where(:field.with_size => 10)
      #
      # @param [ Hash ] criterion The field/size pairs criterion.
      #
      # @return [ Queryable ] The cloned queryable.
      #
      # @since 1.0.0
      def with_size(criterion = nil)
        criterion.update_values(&:to_i) if criterion
        __override__(criterion, "$size")
      end

      ::Symbol.add_key(:with_size, "$size") do |value|
        value.to_i
      end
    end
  end
end
