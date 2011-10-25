# encoding: utf-8
module Origin
  module Selection
    module MaxDistance

      def max_distance(criterion = nil)
        append!(criterion, "$maxDistance")
      end

      ::Symbol.class_eval do

        def max_distance
          Key.new(self, "$maxDistance")
        end
      end
    end
  end
end
