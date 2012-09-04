module Origin

  class Aggregator < Smash

    def project
      self["$project"] = {} unless self["$project"]

      self["$project"]
    end

  end
end
