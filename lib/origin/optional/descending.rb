# encoding: utf-8
module Origin
  module Optional
    module Descending

      def descending(*fields)
        sort_with_list(*fields, -1)
      end
      alias :desc :descending

      ::Symbol.add_key(:desc, -1)
      ::Symbol.add_key(:descending, -1)
    end
  end
end
