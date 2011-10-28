# encoding: utf-8
module Origin
  module Selection
    module MaxDistance

      def max_distance(criterion = nil)
        _append(criterion, "$maxDistance")
      end
    end
  end
end
