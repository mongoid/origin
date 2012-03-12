# encoding: utf-8
module Origin
  module Selectable

    # Provides behaviour for $where or standard selection.
    module Where

      # This is the general entry point for most MongoDB queries. This either
      # creates a standard field: value selection, and expanded selection with
      # the use of hash methods, or a $where selection if a string is provided.
      #
      # @example Add a standard selection.
      #   queryable.where(name: "syd")
      #
      # @example Add a javascript selection.
      #   queryable.where("this.name == 'syd'")
      #
      # @param [ String, Hash ] criterion The javascript or standard selection.
      #
      # @return [ Queryable ] The cloned queryable.
      #
      # @since 1.0.0
      def where(criterion = nil)
        criterion.is_a?(String) ? js_query(criterion) : expr_query(criterion)
      end

      private

      # Create the standard expression query.
      #
      # @api private
      #
      # @example Create the selection.
      #   queryable.expr_query(age: 50)
      #
      # @param [ Hash ] criterion The field/value pairs.
      #
      # @return [ Queryable ] The cloned queryable.
      #
      # @since 1.0.0
      def expr_query(criterion)
        selection(criterion) do |selector, field, value|
          selector.merge!(field.specify(value))
        end
      end

      # Create a javascript selection.
      #
      # @api private
      #
      # @example Create the javascript selection.
      #   queryable.js_query("this.age == 50")
      #
      # @param [ String ] criterion The javascript as a string.
      #
      # @return [ Queryable ] The cloned queryable
      #
      # @since 1.0.0
      def js_query(criterion)
        clone.tap do |query|
          query.selector.merge!("$where" => criterion)
        end
      end
    end
  end
end
