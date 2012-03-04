# encoding: utf-8
module Origin
  module Selectable

    # Provides behaviour for $nor selection.
    module Nor

      #
      # @return [ Queryable ] The cloned queryable.
      #
      # @since 1.0.0
      def nor(*criterion)
        __multi__(criterion, "$nor")
      end
    end
  end
end
