# encoding: utf-8
module Origin
  module Optional
    module OrderBy

      def order_by(*spec)
        option(spec) do |options|
          spec.compact.each do |criterion|
            criterion.as_sorting_options.each_pair do |field, direction|
              add_sort_option(options, field, direction)
            end
          end
        end
      end

      private

      def sort_with_list(*fields, direction)
        option(fields) do |options|
          fields.flatten.compact.each do |field|
            add_sort_option(options, field, direction)
          end
        end
      end

      def add_sort_option(options, field, direction)
        sorting = options[:sort] || {}
        sorting[field] = direction
        options.store(:sort, sorting)
      end
    end
  end
end
