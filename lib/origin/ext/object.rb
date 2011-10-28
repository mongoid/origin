# encoding: utf-8
class Object

  def _add(object)
    return self if object == self
    [ self, object ].flatten.uniq
  end
end
