# coding: utf-8
# frozen_string_literal: true
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'couchdb_rebuild_view_indices/version'

Gem::Specification.new do |spec|
  spec.name          = 'couchdb_rebuild_view_indices'
  spec.version       = CouchdbDesignDocs::VERSION
  spec.authors       = ['Justin Kulesza']
  spec.email         = ['justin.kulesza@atomicobject.com']

  spec.summary       = 'Simple utility to force CouchDB to ' \
                       're-index design documents.'
  spec.description   = 'Simple utility to force CouchDB to ' \
                       're-index design documents.'
  spec.homepage      = 'https://github.com/kuleszaj/couchdb_rebuild_view_indices'
  spec.license       = 'MIT'

  # Prevent pushing this gem to RubyGems.org by setting 'allowed_push_host', or
  # delete this section to allow pushing this gem to any host.
  spec.metadata['allowed_push_host'] = \
    "TODO: Set to 'http://mygemserver.com'" if spec.respond_to?(:metadata)
  raise 'RubyGems 2.0 or newer is required to protect ' \
        'against public gem pushes.' unless spec.respond_to?(:metadata)

  spec.files         = `git ls-files -z`.split("\x0").reject \
                       { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = 'bin'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.11'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
  spec.add_development_dependency 'rubocop'
end
