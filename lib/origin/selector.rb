# encoding: utf-8
module Origin
  class Selector < Hash

    def intersect!(field, operator, value)
      current = fetch(field, nil)
      replacement = current ? current[operator] & value : value
      store(field, { operator => replacement })
    end

    def override!(field, operator, value)
      store(field, { operator => value })
    end

    def union!(field, operator, value)
      current = fetch(field, nil)
      replacement = current ? current[operator] + value : value
      store(field, { operator => replacement })
    end
  end
end
