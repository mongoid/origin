module Origin

  class Aggregator < Smash

    def project
      self["$project"] = {} unless self["$project"]

      self["$project"]
    end

    def limit(limit)
      self["$limit"] = limit
    end

  end
end
