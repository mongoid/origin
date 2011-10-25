# encoding: utf-8
module Origin
  module Selection
    module Where

      def where(criterion = nil)
        assimilate(criterion) do |selector, field, value|
          if field.is_a?(Key)
            selector.merge!(field.specify(value))
          else
            selector.store(field, value)
          end
        end
      end
    end
  end
end
