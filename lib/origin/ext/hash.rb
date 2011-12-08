# encoding: utf-8
class Hash

  def _add(object)
    apply_strategy(:_add, object)
  end

  def _intersect(object)
    apply_strategy(:_intersect, object)
  end

  def _union(object)
    apply_strategy(:_union, object)
  end

  def deep_copy
    inject({}) do |copy, (key, value)|
      copy.tap do |clone|
        case value
        when Array, String then clone.store(key, value.dup)
        when Hash then clone.store(key, value.deep_copy)
        else
          clone.store(key, value)
        end
      end
    end
  end

  private

  def apply_strategy(strategy, object)
    tap do |hash|
      object.each_pair do |key, value|
        hash.store(key, hash[key].send(strategy, value))
      end
    end
  end
end
