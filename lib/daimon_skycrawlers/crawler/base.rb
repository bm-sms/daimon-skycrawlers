require "uri"
require "faraday"

require "daimon_skycrawlers/logger"
require "daimon_skycrawlers/storage"

module DaimonSkycrawlers
  module Crawler
    class Base
      include DaimonSkycrawlers::LoggerMixin

      attr_writer :storage

      def initialize(base_url = nil, options = {})
        @base_url = base_url
        @options = options
        @prepare = ->(connection) {}
      end

      def setup_connection(options = {})
        @connection = Faraday.new(@base_url, @options.merge(options)) do |faraday|
          yield faraday
        end
      end

      #
      # Call this method before DaimonSkycrawlers.register_crawler
      # For example, you can login before fetch URL
      #
      def prepare(&block)
        @prepare = block
      end

      def storage
        @storage ||= Storage::RDB.new
      end

      def connection
        @connection ||= Faraday.new(@base_url, @options)
      end

      def fetch(path, params = {}, **kw)
        raise NotImplementedError, "Must implement this method in subclass"
      end

      def get(path, params = {})
        @connection.get(path, params)
      end

      def post(path, params = {})
        @connection.post(path, params)
      end

      private

      def schedule_to_process(url, message = {})
        DaimonSkycrawlers::Processor.enqueue_http_response(url, message)
      end
    end
  end
end