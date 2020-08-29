# frozen_string_literal: true

module Vox
  module HTTP
    # Standard API errors for bad requests
    class Error < Vox::Error
      # @return [Hash<Symbol, Object>] The response object
      attr_reader :data

      # @return [String, nil] The trace identifier this error originated from.
      attr_reader :trace

      # @!visibility private
      # Create an error from an API response.
      # @param data [Hash<Symbol, Object>] The error object from the API.
      # @param req_id [String] The trace ID for the originating request.
      def initialize(data, req_id = nil)
        @data = data
        @trace = req_id
        super(data[:message])
      end

      # Status Code 400
      class BadRequest < self
      end

      # Status Code 401
      class Unauthorized < self
      end

      # Status Code 403
      class Forbidden < self
      end

      # Status Code 404
      class NotFound < self
      end

      # Status Code 405
      class MethodNotAllowed < self
      end

      # Status Code 429
      class TooManyRequests < self
      end

      # Status Code 502
      class GatewayUnavailable < self
      end

      # Status Code 5XX
      class ServerError < StandardError
        # @!visibility private
        # Create an API error that does not have a JSON body.
        # @param req_id [String] The trace ID of the request.
        def initialize(req_id)
          @trace = req_id
          super('Internal Server Error')
        end
      end
    end
  end
end
