# encoding: utf-8
module Origin
  class Selector < Hash

    def overwrite(key, value)
      store(key.to_s, value)
    end
  end
end
