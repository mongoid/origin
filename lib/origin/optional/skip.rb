# encoding: utf-8
module Origin
  module Optional
    module Skip

      def skip(value = nil)
        clone.tap do |query|
          query.options.store(:skip, value) if value
        end
      end
    end
  end
end
