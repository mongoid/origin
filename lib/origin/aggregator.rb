module Origin

  class Aggregator < Array

    def project(options)
      store "$project", options
    end

    def match(options)
      store "$match", options
    end

    def limit(limit)
      store "$limit", limit
    end

    def skip(skip)
      store "$skip", skip
    end

    def unwind(field)
      store "$unwind", field ? "$#{field}" : nil
    end

    def sort(options)
      store "$sort", options
    end

    private
    def store(key, value)
      return unless value
      self << { key => value }
    end

  end
end
