# encoding: utf-8
module Origin
  module Extensions
    module Symbol

      def add_key(name, operator)
        class_eval <<-EOR
          def #{name}
            Selectable::Key.new(self, #{operator.inspect})
          end
        EOR
      end

      def add_multi_key(name, outer, inner)
        class_eval <<-EOR
          def #{name}
            Selectable::Key.new(self, #{outer.inspect}, #{inner.inspect})
          end
        EOR
      end
    end
  end
end

::Symbol.__send__(:extend, Origin::Extensions::Symbol)
