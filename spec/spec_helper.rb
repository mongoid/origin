$LOAD_PATH.unshift(File.dirname(__FILE__))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), "..", "lib"))

require "i18n"
require "active_support/time"
require "origin"
require "rspec"

class Origin::Query
  include Origin::Queryable
end

class Origin::Aggregation
  include Origin::Aggregatable
end