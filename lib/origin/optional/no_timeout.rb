# encoding: utf-8
module Origin
  module Optional
    module NoTimeout

      def no_timeout
        clone.tap { |query| query.options.store(:timeout, false) }
      end
    end
  end
end
