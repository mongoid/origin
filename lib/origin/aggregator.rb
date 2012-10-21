module Origin

  class Aggregator < Array

    def project(options)
      return unless options
      self << { "$project" => options }
    end

    def limit(limit)
      return unless limit
      self << { "$limit" => limit }
    end

    def skip(skip)
      return unless skip
      self << { "$skip" => skip }
    end

  end
end
