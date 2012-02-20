# encoding: utf-8
module Origin
  module Optional
    module Ascending

      def ascending(*fields)
        sort_with_list(*fields, 1)
      end
      alias :asc :ascending

      ::Symbol.add_key(:asc, 1)
      ::Symbol.add_key(:ascending, 1)
    end
  end
end
