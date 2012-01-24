# encoding: utf-8
module Origin
  module Extensions
    module Integer
      module ClassMethods

        def evolve(object)
          object.is_a?(::Array) ? object.map(&:to_i) : object.to_i
        end
      end
    end
  end
end
