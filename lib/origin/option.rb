# encoding: utf-8
require "origin/option/hint"
require "origin/option/only"
require "origin/option/without"

# require "origin/option/read"
# require "origin/option/skip"
# require "origin/option/limit"
# require "origin/option/snapshot"
# require "origin/option/batch_size"
# require "origin/option/timeout"
# require "origin/option/max_scan"
# require "origin/option/show_disk_loc"
# require "origin/option/return_key"
# require "origin/option/transformer"

module Origin
  module Option
    include Option::Hint
    include Option::Only
    # include Option::OrderBy
    # include Option::Slice
    include Option::Without
  end
end
