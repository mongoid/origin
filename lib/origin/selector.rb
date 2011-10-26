# encoding: utf-8
module Origin
  class Selector < Hash

    def append!(field, operator, value)
      existing = self[field]
      if existing
        store(field, existing.merge({ operator => value }))
      end
    end

    def intersect!(field, operator, value)
      existing = current(field, operator)
      store(field, { operator => existing ? (existing & value) : value })
    end

    def override!(field, operator, value)
      store(field, { operator => value })
    end

    def union!(field, operator, value)
      existing = current(field, operator)
      store(field, { operator => existing ? (existing + value).uniq : value })
    end

    private

    def current(field, operator)
      value = self[field]
      value.is_a?(Hash) ? value[operator] : value ? Array(value) : nil
    end
  end
end
