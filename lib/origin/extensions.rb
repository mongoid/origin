# encoding: utf-8
unless defined?(Boolean)
  class Boolean; end
end

if defined?(ActiveSupport)
  require "origin/extensions/time_with_zone"
end

require "time"
require "origin/extensions/object"
require "origin/extensions/array"
require "origin/extensions/big_decimal"
require "origin/extensions/boolean"
require "origin/extensions/date"
require "origin/extensions/date_time"
require "origin/extensions/hash"
require "origin/extensions/nil_class"
require "origin/extensions/numeric"
require "origin/extensions/range"
require "origin/extensions/set"
require "origin/extensions/string"
require "origin/extensions/symbol"
require "origin/extensions/time"
