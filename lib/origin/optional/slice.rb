# encoding: utf-8
module Origin
  module Optional
    module Slice

      def slice(criterion = nil)
        option(criterion) do |options|
          options._union(
            :fields => criterion.inject({}) do |option, (field, val)|
              option.tap { |opt| opt.store(field, { "$slice" => val }) }
            end
          )
        end
      end
    end
  end
end
