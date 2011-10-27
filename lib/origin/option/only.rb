# encoding: utf-8
module Origin
  module Option
    module Only

      def only(*args)
        clone.tap do |query|
          unless args.compact.empty?
            query.options.store(
              :fields, args.inject({}){ |sub, field| sub.tap { sub[field] = 1 }}
            )
          end
        end
      end
    end
  end
end
