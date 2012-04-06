Overview
========

About Origin
------------

Origin is a DSL for building MongoDB queries.

Compatibility
-------------

Origin is tested against MRI 1.9.2, 1.9.3, 2.0.0, and JRuby (1.9).

<img src="https://secure.travis-ci.org/mongoid/origin.png?branch=master&.png"/>

[Build History](http://travis-ci.org/mongoid/origin)

Documentation
-------------

Until the official website is complete, please use this README as
a documentation reference.

Inclusion
---------

Origin provides a DSL to mix in to any object to give it the ability
to build MongoDB queries easily. Simply include the module
`Origin::Queryable` to get started.

``` ruby
class Criteria
  include Origin::Queryable
end
```

*From here on out when a `Criteria` object is instantiated, assume it
already includes `Origin::Queryable`.*

The Queryable provides a default constructor that takes 2 optional
parameters, a hash of aliased field mappings, and a hash of name and
serializer pairs. Let's discuss aliases first.

In MongoDB, since the database is schemaless and the field names are
included for every document in the JSON, much more storage space is
required than traditional databases with schemas. Because of this,
a common practice is to store very short field names in the documents
to conserve space. This is not ideal from a business domain standpoint
so mappers like Mongoid provide alias functionality to keep the
domain model expressive. An example of this in Mongoid is:

``` ruby
class Band
  include Mongoid::Document
  field :n, as: :name, type: String
end
```

In the above example you can reference the field by `Band#name`, but the
field in the database is stored as `n`. We want to maintain this
expressiveness in querying the database as well, so the Queryable needs
a hash to know how to map the name to the field in the database.

``` ruby
Criteria.new({ "n" => "name" })
```

The aliases hash *must* be string keys and string values. Then you can do
this and it will get converted to the database field name `n`:

``` ruby
criteria.where(name: "value")
```

The second optional parameter is a hash of field names with associated
serializers. This is useful for when MongoDB cannot handle the Ruby
object on the database side, so some form of transformation must occur.
Serializers are Ruby objects that respond to `#evolve`. A good example
of this are Date objects in Ruby, which must be converted to UTC
times for MongoDB.

``` ruby
class DateSerializer
  def evolve(date)
    Time.utc(date.year, date.month, date.day, 0, 0, 0, 0)
  end
end

criteria = Criteria.new({}, { "dob" => DateSerializer.new })
criteria.where(dob: Date.new(1970, 1, 1)) # Converts dob to a time.
```

If you'd like to have convenience methods added to a model, you can extend
`Origin::Forwardable` and tell the queryable methods which class method
to delegate to. This will add all the public queryable methods to that
class.

``` ruby
class Band
  extend Origin::Forwardable
  select_with :criteria

  def self.criteria
    Criteria.new(aliases, serializers)
  end
end

Band.where(name: "Depeche Mode")
```

*From here on, assume all references to the `Band` class have extended
`Origin::Forwardable`.*

Selection
---------

The `Queryable` provides convenience methods for every type of MongoDB
query operation you can perform. For example, to add $all selection to the
queryable.

``` ruby
Band.all(labels: [ "Mute", "Nothing" ])
```

This translates to the following selector.

``` ruby
{ "labels" => { "$all" => [ "Mute", "Nothing" ]}}
```

See the API documentation for all available methods that the `Queryable`
provides, in it's internal `Selectable` and `Optional` modules.

- [Selectable API](http://rdoc.info/github/mongoid/origin/Origin/Selectable)
- [Optional API](http://rdoc.info/github/mongoid/origin/Origin/Optional)

In addition to all the convenience methods for selection, Origin also adds
various convenience methods to `Symbol` which can be used *only* within
`#where` selection for syntax suger. For example:

``` ruby
Band.where(:name.in => [ "Depeche Mode", "New Order" ])
```

This translates to the following selector.

``` ruby
{ "name" => { "$in" => [ "Depeche Mode", "New Order" ] }}
```

The API documentation contains all the corresponding symbol methods as well
in the example annotations for each standard method.

`Queryable#where` is also special in that it can take a Javascript string as
a parameter, that will create the corresponding $where selection.

``` ruby
Band.where("this.name == 'Depeche Mode'")
```

Translates to:

``` ruby
{ "$where" => "this.name == 'Depeche Mode'" }
```

*Note that passing Javascript alone by itself to MongoDB will cause a full
collection scan.*

### Merge strategies

The selection API also provides merge strategies for cases you want to
override the default behaviour with specific methods that expect array values.
The available strategies are *intersect, override, and union* and are used by
chaining the name of the strategy before calling any method. For example,
to override the default *intersection* behaviour of `#in`:

``` ruby
Band.in(name: [ "Depeche Mode" ]).union.in(name: [ "New Order" ])
```

This translates to the following selector.

``` ruby
{ "name" => { "$in" => [ "Depeche Mode", "New Order" ] }}
```

The default behaviour for the array methods are:

* `Queryable#all` - defaults to *union*.
* `Queryable#in` - defaults to *intersect*.
* `Queryable#nin` - defaults to *intersect*.

### Notes on queryable chaining

Each time a method on the queryable is called, it clones itself and returns
a new copy with the next selection added. This is to not modify the previous
queryable in case it needs reuse later on without the additional selection.

### Notes on sorting syntax

By default, Origin's sort options are in a format that is compatible with
Moped, but not the 10gen Ruby driver. (It's a hash vs a multi-dimensional
array.)

If you would like the sorting options to be compatible with the 10gen
driver, then when instantiating a `Queryable` you'll need to pass `:mongo`
as the third parameter to the constructor.

``` ruby
Criteria.new(aliases, serializers, :mongo)
```
