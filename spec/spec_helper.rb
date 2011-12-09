$LOAD_PATH.unshift(File.dirname(__FILE__))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), "..", "lib"))
require "origin"
require "rspec"

class Origin::Query
  include Origin::Queryable
end
