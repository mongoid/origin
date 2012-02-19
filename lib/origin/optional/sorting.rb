# encoding: utf-8
module Origin
  module Optional
    module Sorting

      def ascending(*fields)
        sort_with_list(*fields, 1)
      end
      alias :asc :ascending

      def descending(*fields)
        sort_with_list(*fields, -1)
      end
      alias :desc :descending

      private

      def sort_with_list(*fields, direction)
        sort = fields.flatten.compact
        option(fields) do |options|
          sort.each do |field|
            (options[:sort] ||= {})[field.to_sym] = direction
          end
        end
      end
    end
  end
end
