# encoding: utf-8
module Origin
  module Selection

    autoload :All, "origin/selection/all"
    autoload :And, "origin/selection/and"
    autoload :Between, "origin/selection/between"
    autoload :ElemMatch, "origin/selection/elem_match"
    autoload :Exists, "origin/selection/exists"
    autoload :Gt, "origin/selection/gt"
    autoload :Gte, "origin/selection/gte"
    autoload :In, "origin/selection/in"
    autoload :Key, "origin/selection/key"
    autoload :Lt, "origin/selection/lt"
    autoload :Lte, "origin/selection/lte"
    autoload :MaxDistance, "origin/selection/max_distance"
    autoload :Mod, "origin/selection/mod"
    autoload :Ne, "origin/selection/ne"
    autoload :Near, "origin/selection/near"
    autoload :NearSphere, "origin/selection/near_sphere"
    autoload :Nin, "origin/selection/nin"
    autoload :Nor, "origin/selection/nor"
    autoload :Or, "origin/selection/or"
    autoload :Size, "origin/selection/size"
    autoload :Strategies, "origin/selection/strategies"
    autoload :Type, "origin/selection/type"
    autoload :Where, "origin/selection/where"
    autoload :WithinBox, "origin/selection/within_box"
    autoload :WithinCircle, "origin/selection/within_circle"
    autoload :WithinSphericalCircle, "origin/selection/within_spherical_circle"

    include All
    include And
    include Between
    include ElemMatch
    include Exists
    include Gt
    include Gte
    include In
    include Lt
    include Lte
    include MaxDistance
    include Mod
    include Ne
    include Near
    include NearSphere
    include Nin
    include Nor
    include Or
    include Size
    include Strategies
    include Type
    include Where
    include WithinBox
    include WithinCircle
    #include WithinPolygon
    include WithinSphericalCircle
  end
end
