# encoding: utf-8
require "origin/selection/all"
require "origin/selection/key"

module Origin

  # Origin is a DSL that sits on top of the MongoDB query language, extracted
  # from Mongoid 2 into it's own gem.
  module Selection
    include Selection::All
    # include Selection::And
    # include Selection::Between
    # include Selection::ElemMatch
    # include Selection::Exists
    # include Selection::Gt
    # include Selection::Gte
    # include Selection::In
    # include Selection::Lt
    # include Selection::Lte
    # include Selection::Mod
    # include Selection::Ne
    # include Selection::Nin
    # include Selection::Nor
    # include Selection::Or
    # include Selection::Size
    # include Selection::Type
    # include Selection::Where
  end
end
