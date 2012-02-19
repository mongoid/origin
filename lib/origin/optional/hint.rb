# encoding: utf-8
module Origin
  module Optional
    module Hint

      def hint(*args)
        option(*args) do |options|
          options.store(
            :hint, args.inject({}){ |sub, field| sub.tap { sub[field] = 1 }}
          )
        end
      end
    end
  end
end
