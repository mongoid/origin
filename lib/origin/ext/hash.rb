# encoding: utf-8
class Hash

  def _add(object)
    tap do |hash|
      object.each_pair do |key, value|
        hash.store(key, hash[key]._add(value))
      end
    end
  end

  def _intersect(object)
    tap do |hash|
      object.each_pair do |key, value|
        hash.store(key, hash[key]._intersect(value))
      end
    end
  end
end
