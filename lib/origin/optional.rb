# encoding: utf-8
module Origin
  module Optional

    autoload :BatchSize, "origin/optional/batch_size"
    autoload :Hint, "origin/optional/hint"
    autoload :Limit, "origin/optional/limit"
    autoload :MaxScan, "origin/optional/max_scan"
    autoload :NoTimeout, "origin/optional/no_timeout"
    autoload :Only, "origin/optional/only"
    autoload :Read, "origin/optional/read"
    autoload :ReturnKey, "origin/optional/return_key"
    autoload :ShowDiskLoc, "origin/optional/show_disk_loc"
    autoload :Skip, "origin/optional/skip"
    autoload :Slice, "origin/optional/slice"
    autoload :Snapshot, "origin/optional/snapshot"
    autoload :Transformer, "origin/optional/transformer"
    autoload :Without, "origin/optional/without"

    include BatchSize
    include Hint
    include Limit
    include MaxScan
    include NoTimeout
    include Only
    include Read
    include ReturnKey
    include ShowDiskLoc
    include Skip
    include Slice
    include Snapshot
    include Transformer
    include Without
  end
end
