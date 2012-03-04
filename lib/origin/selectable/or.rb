# encoding: utf-8
module Origin
  module Selectable

    # Provides behaviour for $or selection.
    module Or

      #
      # @return [ Queryable ] The cloned queryable.
      #
      # @since 1.0.0
      def or(*criterion)
        __multi__(criterion, "$or")
      end
      alias :any_of :or
    end
  end
end
