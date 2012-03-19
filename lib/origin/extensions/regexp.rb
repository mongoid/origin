# encoding: utf-8
module Origin
  module Extensions

    # This module contains additional regex behaviour.
    module Regexp

      def regexp?; true; end

      module ClassMethods

        def evolve(object)
          __evolve__(object) do |obj|
            ::Regexp.new(obj)
          end
        end
      end
    end
  end
end

::Regexp.__send__(:include, Origin::Extensions::Regexp)
::Regexp.__send__(:extend, Origin::Extensions::Regexp::ClassMethods)
