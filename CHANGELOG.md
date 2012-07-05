# Overview

## 1.1.0 (branch: master)

### New Features

### Resolved Issues

## 1.0.2

### Resolved Issues

* mongoid/mongoid \#2165 Multi selection ($and/$or) now takes into account
  field aliases.

## 1.0.1

### Resolved Issues

* \#38 Fixed issues around UTC time conversion of dates and date times:

    `DateTimes` already in UTC are not converted to UTC again.

    `Dates` properly convert directly to UTC from numeric values.
