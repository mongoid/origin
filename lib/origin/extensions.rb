# encoding: utf-8
unless defined?(Boolean)
  class Boolean; end
end

module Kernel
  def require_all(current, files)
    Dir[ File.join(File.dirname(current), files, "*.rb") ].each do |file|
      require file
    end
  end
end

require_all __FILE__, "extensions"
