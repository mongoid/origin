# encoding: utf-8
module Origin
  module Selectable
    module WithinPolygon

      def within_polygon(criterion = nil)
        __expanded__(criterion, "$within", "$polygon")
      end

      ::Symbol.add_multi_key(:within_polygon, "$within", "$polygon")
    end
  end
end
