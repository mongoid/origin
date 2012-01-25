# encoding: utf-8
require "origin/extensions/array"
require "origin/extensions/big_decimal"
require "origin/extensions/hash"
require "origin/extensions/integer"
require "origin/extensions/nil_class"
require "origin/extensions/object"

Array.send(:include, Origin::Extensions::Array)
BigDecimal.send(:extend, Origin::Extensions::BigDecimal::ClassMethods)
Hash.send(:include, Origin::Extensions::Hash)
Integer.send(:extend, Origin::Extensions::Integer::ClassMethods)
NilClass.send(:include, Origin::Extensions::NilClass)
Object.send(:include, Origin::Extensions::Object)
Object.send(:extend, Origin::Extensions::Object::ClassMethods)
