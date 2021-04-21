# frozen_string_literal: true

module NomadClient
  module Api
    class Path
      # @!attribute nomad_connection
      #   @return [NomadClient::Connection]
      attr_accessor :nomad_connection

      def initialize(nomad_connection)
        @nomad_connection = nomad_connection
      end

      def connection
        @nomad_connection.connection
      end
    end
  end
end
