module NomadClient
  class Connection
    def allocation
      Api::Allocation.new(self)
    end
  end
  module Api
    class Allocation < Path

      ##
      # Query a specific allocation
      # https://www.nomadproject.io/docs/http/alloc.html
      #
      # @param [String] id The ID of the allocation according to Nomad
      # @return [Faraday::Response] A faraday response from Nomad
      def get(id)
        connection.get do |req|
          req.url "allocation/#{id}"
        end
      end

      ##
      # Restart an allocation or task in-place.
      # https://www.nomadproject.io/api/allocations.html#restart-allocation
      # @param [String] id The full UUID of the allocation
      # @param [String] task [Optional] Task to be restarted. If unspecified, all tasks will be restarted.
      # @return [Faraday::Response] A faraday response from Nomad
      def restart(id, task = nil)
        connection.post do |req|
          req.url "client/allocation/#{id}/restart"
          req.body = { 'Task' => task } unless task.nil?
        end
      end

      ##
      # Stops and reschedules a specific allocation.
      # https://www.nomadproject.io/api-docs/allocations#stop-allocation
      # @param [String] id The full UUID of the allocation
      # @return [Faraday::Response] A faraday response from Nomad
      def stop(id)
        connection.post do |req|
          req.url "allocation/#{id}/stop"
        end
      end
    end
  end
end
