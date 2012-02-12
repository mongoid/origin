module Kernel

  def require_all(current, files)
    Dir[ File.join(File.dirname(current), files, "*.rb") ].each do |file|
      require file
    end
  end
end
