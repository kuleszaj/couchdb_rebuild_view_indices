# frozen_string_literal: true
require 'couchdb_rebuild_view_indices/version'
require 'net/http'
require 'json'
require 'logger'

module CouchdbRebuildViewIndices
  # Class for describing an indexer of CouchDB design documents.
  class Indexer

    attr_writer :options

    @@default_options = {
      host: '127.0.0.1',
      retries: 10,
      port: 5984,
      protocol: 'http',
      log_level: Logger::INFO
    }

    def initialize(options)
      @options = @@default_options.merge!(options)
      @logger = Logger.new(STDOUT)
      @logger.level = @options[:log_level]
      @logger.debug 'Running with options:'
      @logger.debug @options
    end

    def run!
      docs = get_design_docs(design_docs_uri)
      docs.each do |doc|
        next unless doc['doc'].key?('views')
        iterate_on_views(doc['id'], doc['doc']['views'])
      end
    end

    private

    def iterate_on_views(document_id, views)
      views.each do |view|
        @logger.info "Requesting view: #{document_id}/_view/#{view[0]}"
        res = make_request_with_retries(
          view_uri(document_id, view[0]),
          @options[:retries]
        )
        @logger.info 'OK!' if res.code == '200'
        @logger.info 'Error!' if res.code != '200'
      end
    end

    def get_design_docs(uri)
      JSON.parse(make_request_with_retries(uri).body)['rows']
    end

    def design_docs_uri
      URI::HTTP.build(
        scheme: @options[:protocol],
        host: @options[:host],
        port: @options[:port],
        path: "/#{@options[:database]}/_all_docs",
        query: 'startkey=%22_design/%22&endkey=%22_design0%22&include_docs=true'
      )
    end

    def view_uri(document_id, view)
      URI::HTTP.build(
        scheme: @options[:protocol],
        host: @options[:host],
        port: @options[:port],
        path: "/#{@options[:database]}/#{document_id}/_view/#{view}"
      )
    end

    def make_request_with_retries(uri, retries = 1)
      raise Net::ReadTimeout if retries.negative?
      req = Net::HTTP::Get.new(uri)

      if @options[:username] && @options[:password]
        req.basic_auth @options[:username], @options[:password]
      end

      begin
        Net::HTTP.start(uri.hostname, uri.port) { |http| http.request(req) }
      rescue Net::ReadTimeout
        make_request_with_retries(url, retries - 1)
      end
    end
  end
end
