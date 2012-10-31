# Overview

## 1.1.0 (branch: master)

### New Features

### Resolved Issues

## 1.0.10

### Resolved Issues

* \#51 hash equality works corectly with `Origin::Key`s (Gerad Suyderhoud)

      { :foo.all => [1, 2] } == { :foo.all => [1, 2] } #=> true

## 1.0.9

### Resolved Issues

* \#45 Fixed $not query negation with regular expressions. (Andrew Bennett)

## 1.0.8

### Resolved Issues

* \#44 Fixed serialization on deeply nested $and and $or queries. (Egor Lynko)

## 1.0.7

### Resolved Issues

* \#40 Allow $elemMatch queries to be expanded in where clauses, not just
  elem_match method calls.

## 1.0.5

### Resolved Issues

* \#40 Allow $elemMatch queries to be expanded.

## 1.0.4

### Resolved Issues

* \#39 Fixed errors when using forwarding when active support is not present.

## 1.0.3

### Resolved Issues

* mongoid/mongoid\#2170 Multi selection ($and/$or) now properly concats
  when merging two criteria.

## 1.0.2

### Resolved Issues

* mongoid/mongoid\#2165 Multi selection ($and/$or) now takes into account
  field aliases.

## 1.0.1

### Resolved Issues

* \#38 Fixed issues around UTC time conversion of dates and date times:

    `DateTimes` already in UTC are not converted to UTC again.

    `Dates` properly convert directly to UTC from numeric values.
