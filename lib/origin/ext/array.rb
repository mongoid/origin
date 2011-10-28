# encoding: utf-8
class Array

  def _add(object)
    if object.is_a?(Hash)
      object[object.keys.first] = _add(object.values.first)
      object
    else
      concat(Array(object)).uniq
    end
  end

  def _intersect(object)
    if object.is_a?(Hash)
      object[object.keys.first] = _intersect(object.values.first)
      object
    else
      self & Array(object)
    end
  end
end
