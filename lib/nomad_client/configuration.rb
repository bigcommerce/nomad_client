# frozen_string_literal: true

module NomadClient
  class Configuration
    # FQDN of the Nomad you're talking to, e.g: https://nomad.local
    attr_accessor :url

    # Nomad's bound port, by default this is 4646
    attr_accessor :port

    # Nomad's HTTP API base path, as of writing this is /v1
    attr_accessor :api_base_path

    # SSL configuration hash, specifically the one Faraday expects,
    # see https://gist.github.com/mislav/938183 for a quick example
    attr_accessor :ssl

    # Faraday configuration
    attr_accessor :timeout
    attr_accessor :open_timeout
    attr_accessor :retry_max
    attr_accessor :retry_interval
    attr_accessor :retry_randomness
    attr_accessor :retry_backoff_factor

    # net-http-persistent configuration
    attr_accessor :pool_size
    attr_accessor :idle_timeout
    attr_accessor :retry_change_requests

    DEFAULT_PORT                  = 4_646
    DEFAULT_API_BASE_PATH         = '/v1'
    DEFAULT_SSL                   = {}.freeze
    DEFAULT_TIMEOUT               = 5
    DEFAULT_OPEN_TIMEOUT          = 2
    DEFAULT_RETRY_MAX             = 3
    DEFAULT_RETRY_INTERVAL        = 1.0
    DEFAULT_RETRY_RANDOMNESS      = 0.5
    DEFAULT_RETRY_BACKOFF_FACTOR  = 2.0
    DEFAULT_POOL_SIZE             = 5
    DEFAULT_IDLE_TIMEOUT          = 100
    DEFAULT_RETRY_CHANGE_REQUESTS = true

    def initialize
      @port                  = DEFAULT_PORT
      @api_base_path         = DEFAULT_API_BASE_PATH
      @ssl                   = DEFAULT_SSL
      @timeout               = DEFAULT_TIMEOUT
      @open_timeout          = DEFAULT_OPEN_TIMEOUT
      @retry_max             = DEFAULT_RETRY_MAX
      @retry_interval        = DEFAULT_RETRY_INTERVAL
      @retry_randomness      = DEFAULT_RETRY_RANDOMNESS
      @retry_backoff_factor  = DEFAULT_RETRY_BACKOFF_FACTOR
      @pool_size             = DEFAULT_POOL_SIZE
      @idle_timeout          = DEFAULT_IDLE_TIMEOUT
      @retry_change_requests = DEFAULT_RETRY_CHANGE_REQUESTS
    end
  end
end
