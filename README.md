# Couchdb Rebuild View Indices

This is a simple utilize to initiate the rebuild of indices associated with the views of CouchDB design documents. This is particularly useful after migrating a CouchDB via a restore from a dumped file.

Generally, CouchDB updates the indices of views for design documents when accessed. However, if an entire CouchDB with much data has just been restored, it is difficult to ensure that all indexes are updated prior to running a live system against the new CouchDB.

This utility enumerates and accesses all views for all design documents, which causes CouchDB to initiate a rebuild of all indices.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'couchdb_rebuild_view_indices'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install couchdb_rebuild_view_indices

## Usage

```
bin/rebuild-view-indices

Usage: rebuild-view-indices [options]
    -u, --username [USERNAME]        Username for basic auth. (e.g. 'admin')
    -p, --password [PASSWORD]        Password for basic auth. (e.g. 'secret')
    -H, --host [HOST]                CouchDB Host. (e.g. '192.168.0.1')
    -P, --port [PORT]                CouchDB Port. (default: 5984)
        --protocol [PROTOCOL]        Protocol for HTTP requests. (default: http)
    -h, --help                       Show this message.
    -R, --retries [RETRIES]          Number of times to retry a request before timing out. (default: 10)
    -d, --database DATABASE          CouchDB database. (e.g. 'default')
    -v, --verbose                    Turn on debug logging.
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/kuleszaj/couchdb_rebuild_view_indices.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT). See [LICENSE.txt](LICENSE.txt).
