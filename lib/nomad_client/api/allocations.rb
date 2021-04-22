# frozen_string_literal: true

module NomadClient
  class Connection
    def allocations
      Api::Allocations.new(self)
    end
  end

  module Api
    class Allocations < Path
      ##
      # Lists all the allocations
      # https://www.nomadproject.io/docs/http/allocs.html
      #
      # @return [Faraday::Response] A faraday response from Nomad
      def get
        connection.get do |req|
          req.url "allocations"
        end
      end
    end
  end
end
