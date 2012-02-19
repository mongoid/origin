# encoding: utf-8
module Origin
  module Optional
    module ReturnKey

      def return_key
        clone.tap { |query| query.options.store(:return_key, true) }
      end
    end
  end
end
