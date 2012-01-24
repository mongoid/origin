# encoding: utf-8
module Origin
  module Extensions
    module NilClass

      def __add__(object); object end

      def __intersect__(object); object end

      def __union__(object); object end
    end
  end
end
