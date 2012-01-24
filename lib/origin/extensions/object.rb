# encoding: utf-8
class Object

  def __add__(object)
    object == self ? self : [ self, object ].flatten.uniq
  end

  def __intersect__(object)
    if object.is_a?(Hash)
      object[object.keys.first] = __intersect__(object.values.first)
      object
    else
      Array(self) & Array(object)
    end
  end

  def __union__(object)
    if object.is_a?(Hash)
      object[object.keys.first] = __union__(object.values.first)
      object
    else
      (Array(self) + Array(object)).uniq
    end
  end

  def __deep_copy__
    self
  end
end
