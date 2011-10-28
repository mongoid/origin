# encoding: utf-8
class Object

  def _add(object)
    object == self ? self : [ self, object ].flatten.uniq
  end

  def _intersect(object)
    if object.is_a?(Hash)
      object[object.keys.first] = _intersect(object.values.first)
      object
    else
      Array(self) & Array(object)
    end
  end

  def _union(object)
    if object.is_a?(Hash)
      object[object.keys.first] = _union(object.values.first)
      object
    else
      (Array(self) + Array(object)).uniq
    end
  end
end
