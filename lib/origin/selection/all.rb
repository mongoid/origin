# encoding: utf-8
module Origin
  module Selection
    module All

      def all(criterion = nil)
        clone.tap do |query|
          if criterion
            criterion.each_pair do |field, values|
              query.selector.overwrite(field, { "$all" => values })
            end
          end
        end
      end

      ::Symbol.class_eval do

        def all
          Key.new(self.to_s, "$all")
        end
      end
    end
  end
end
