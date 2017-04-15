# encoding: utf-8
unless defined?(ActionController)
  module ActionController
    class Parameters; end
  end
end

require "origin/forwardable"
require "origin/queryable"
require "origin/version"
