# encoding: utf-8
module Origin
  module Extensions
    module Integer
      module ClassMethods

        def evolve(object)
          object.to_i
        end
      end
    end
  end
end
