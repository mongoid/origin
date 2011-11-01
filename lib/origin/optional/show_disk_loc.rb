# encoding: utf-8
module Origin
  module Optional
    module ShowDiskLoc

      def show_disk_loc
        clone.tap { |query| query.options.store(:show_disk_loc, true) }
      end
    end
  end
end
