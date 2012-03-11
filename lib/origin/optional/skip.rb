# encoding: utf-8
module Origin
  module Optional
    module Skip

      def skip(value = nil)
        option(value) { |options| options.store(:skip, value.to_i) }
      end
    end
  end
end
