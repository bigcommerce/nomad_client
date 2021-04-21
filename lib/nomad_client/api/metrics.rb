# frozen_string_literal: true

module NomadClient
  class Connection
    def metrics
      Api::Metrics.new(self)
    end
  end

  module Api
    class Metrics < Path
      ##
      # The /metrics endpoint returns metrics for the current Nomad process.
      # https://www.nomadproject.io/api/metrics.html
      #
      # @param [String] format Specifies the metrics format to be other than the JSON default. This is specified as a querystring parameter.
      #
      # @return [Faraday::Response] A faraday response from Nomad
      def get(format: nil)
        connection.get do |req|
          req.url "metrics"
          req.params[:format] = format
        end
      end
    end
  end
end
