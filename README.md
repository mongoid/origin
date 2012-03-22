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
a documentaion reference.

Inclusion
---------

Origin provides a DSL to mix in to any object to give it the ability
to build MongoDB queries easily. Simply include the module
`Origin::Queryable` to get started.

        class Criteria
          include Origin::Queryable
        end

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

        class Band
          include Mongoid::Document
          field :n, as: :name, type: String
        end

In the above example you can reference the field by `Band#name`, but the
field in the database is stored as `d`. We want to maintain this
expressiveness in querying the database as well, so the Queryable needs
a hash to know how to map the name to the field in the database.

        Criteria.new({ "n" => "name" })

The aliases hash *must* be string keys and string values.

The second optional parameter is a hash of field names with associated
serializers. This is useful for when MongoDB cannot handle the Ruby
object on the database side, so some form of transformation must occur.
Serializers are Ruby objects that respond to `#evolve`. A good example
of this are Date objects in Ruby, which must be converted to UTC
times for MongoDB.

        class DateSerializer
          def evolve(date)
            Time.utc(date.year, date.month, date.day, 0, 0, 0, 0)
          end
        end

        criteria = Criteria.new({}, { "dob" => DateSerializer.new })
        criteria.where(dob: Date.new(1970, 1, 1)) # Converts dob to a time.

If you'd like to have convenience methods added to a model, you can extend
`Origin::Forwardable` and tell the queryable methods which class method
to delegate to. This will add all the public queryable methods to that
class.

        class Band
          extend Origin::Forwardable
          select_with :criteria

          def self.criteria
            Criteria.new(aliases, serializers)
          end
        end

        Band.where(name: "Depeche Mode")

*From here on, assume all references to the `Band` class have extended
`Origin::Forwardable`.*

Selection
---------

The `Queryable` provides convenience methods for every type of MongoDB
query operation you can perform. For example, to add $all selection to the
queryable.

        Band.all(labels: [ "Mute", "Nothing" ])

This translates to the following selector.

        { "labels" => { "$all" => [ "Mute", "Nothing" ]}}

See the API documentation for all available methods that the `Queryable`
provides, in it's internal `Selectable` module.

[Selectable API](http://rdoc.info/github/mongoid/origin/Origin/Selectable)

In addition to all the convenience methods for selection, Origin also adds
various convenience methods to `Symbol` which can be used *only* within
`#where` selection for syntax suger.

        Band.where(:name.in => [ "Depeche Mode", "New Order" ])

The API documentation contains all the corresponding symbol methods as well
in the example annotations for each standard method.
