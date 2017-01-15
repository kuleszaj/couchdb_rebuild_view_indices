# coding: utf-8
# frozen_string_literal: true
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'couchdb_rebuild_view_indices/version'

Gem::Specification.new do |spec|
  spec.name          = 'couchdb_rebuild_view_indices'
  spec.version       = CouchdbRebuildViewIndices::VERSION
  spec.authors       = ['Justin Kulesza']
  spec.email         = ['justin.kulesza@atomicobject.com']

  spec.summary       = 'Simple utility to initiate the rebuild of indices '
                       'assocated with views in CouchDB design documents.'
  spec.description   = 'Simple utility to initiate the rebuild of indices '
                       'assocated with views in CouchDB design documents.'

  spec.homepage      = 'https://github.com/kuleszaj/couchdb_rebuild_view_indices'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0").reject \
                       { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = 'bin'
  spec.executables   = spec.files.grep(%r{rebuild-view-indices}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.cert_chain    = ['certs/kuleszaj.pem']
  spec.signing_key   = File.expand_path('~/.ssh/gem-private_key.pem') if $0 =~ /gem\z/

  spec.add_development_dependency 'bundler', '~> 1.11'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
  spec.add_development_dependency 'rubocop', '~> 0.43.0'
end
