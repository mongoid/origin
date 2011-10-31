# encoding: utf-8
module Origin
  module Optional
    module Without

      def without(*args)
        option(*args) do |options|
          options.store(
            :fields, args.inject({}){ |sub, field| sub.tap { sub[field] = -1 }}
          )
        end
      end
    end
  end
end
