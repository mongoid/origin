# encoding: utf-8
require "origin/optional/hint"
require "origin/optional/no_timeout"
require "origin/optional/only"
require "origin/optional/read"
require "origin/optional/snapshot"
require "origin/optional/without"

# require "origin/optional/skip"
# require "origin/optional/limit"
# require "origin/optional/batch_size"
# require "origin/optional/max_scan"
# require "origin/optional/show_disk_loc"
# require "origin/optional/return_key"
# require "origin/optional/transformer"

module Origin
  module Optional
    include Hint
    include NoTimeout
    include Only
    include Read
    include Snapshot
    include Without
  end
end
