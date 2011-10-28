# encoding: utf-8
class NilClass

  def _add(object)
    object
  end

  def _intersect(object)
    Array(object)
  end
end
