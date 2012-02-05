# encoding: utf-8
module Origin
  module Selectable
    module MaxDistance

      def max_distance(criterion = nil)
        __add__(criterion, "$maxDistance")
      end
    end
  end
end
