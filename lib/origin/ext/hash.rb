# encoding: utf-8
class Hash

  def _add(object)
    object.each_pair do |key, value|
      store(key, self[key]._add(value))
    end
  end

  def _intersect(object)
    object.each_pair do |key, value|
      store(key, self[key]._intersect(value))
    end
  end
end
