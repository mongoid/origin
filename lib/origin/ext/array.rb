# encoding: utf-8
class Array

  def _add(object)
    concat(Array(object)).uniq
  end
end
