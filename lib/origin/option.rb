# encoding: utf-8
require "origin/option/only"
require "origin/option/without"

module Origin
  module Option
    # include Option::Hint
    include Option::Only
    # include Option::OrderBy
    # include Option::Slice
    include Option::Without
  end
end
