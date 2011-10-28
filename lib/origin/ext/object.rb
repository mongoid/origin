# encoding: utf-8
class Object

  def _add(object)
    object == self ? self : [ self, object ].flatten.uniq
  end

  def _intersect(object)
    Array(self) & Array(object)
  end
end
