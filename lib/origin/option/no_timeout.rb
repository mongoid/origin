# encoding: utf-8
module Origin
  module Option
    module NoTimeout

      def no_timeout
        clone.tap do |query|
          query.options.store(:timeout, false)
        end
      end
    end
  end
end
