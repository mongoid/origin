# encoding: utf-8
module Origin
  module Selectable

    # Provides behaviour for $where or standard selection.
    module Where

      #
      # @return [ Queryable ] The cloned queryable.
      #
      # @since 1.0.0
      def where(criterion = nil)
        criterion.is_a?(String) ? js_query(criterion) : expr_query(criterion)
      end

      private

      def expr_query(criterion)
        selection(criterion) do |selector, field, value|
          if field.is_a?(Key)
            selector.merge!(field.specify(value))
          else
            selector.store(field, value)
          end
        end
      end

      def js_query(criterion)
        clone.tap do |query|
          query.selector.merge!("$where" => criterion)
        end
      end
    end
  end
end
