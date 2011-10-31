# encoding: utf-8
require "origin/optional/hint"
require "origin/optional/no_timeout"
require "origin/optional/only"
require "origin/optional/without"

# require "origin/optional/read"
# require "origin/optional/skip"
# require "origin/optional/limit"
# require "origin/optional/snapshot"
# require "origin/optional/batch_size"
# require "origin/optional/max_scan"
# require "origin/optional/show_disk_loc"
# require "origin/optional/return_key"
# require "origin/optional/transformer"

module Origin
  module Optional
    include Optional::Hint
    include Optional::NoTimeout
    include Optional::Only
    # include Optional::OrderBy
    # include Optional::Slice
    include Optional::Without
  end
end
