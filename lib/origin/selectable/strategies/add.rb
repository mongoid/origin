# encoding: utf-8
module Origin
  module Selectable
    module Strategies
      module Add

        def __add__(criterion, operator)
          with_strategy(:__add__, criterion, operator)
        end
      end
    end
  end
end
