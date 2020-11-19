require 'faraday'
require 'faraday_middleware'
require 'net/http'
module NomadClient
  class Connection

    attr_accessor :configuration

    def initialize(url, config = Configuration.new)
      config.url = url
      yield(config) if block_given?
      @configuration = config
    end

    def connection
      @connection ||= ::Faraday.new({ url: connection_url, ssl: configuration.ssl }) do |faraday|
        faraday.request(:json)
        faraday.request(:retry, retry_options)
        faraday.use(FaradayMiddleware::Mashify)
        faraday.response(:json, :content_type => /\bjson$/)
        faraday.options.timeout = configuration.timeout
        faraday.options.open_timeout = configuration.open_timeout

        # Use Net::HTTP if pool_size is set to 0
        if configuration.pool_size == 0
          faraday.adapter(:net_http) do |http|
            http.idle_timeout = configuration.idle_timeout
            http.retry_change_requests = configuration.retry_change_requests
          end
        else
          faraday.adapter(:net_http_persistent, pool_size: configuration.pool_size) do |http|
            http.idle_timeout = configuration.idle_timeout
            http.retry_change_requests = configuration.retry_change_requests
          end
        end
      end
    end

    def connection_url
      "#{configuration.url}:#{configuration.port}#{configuration.api_base_path}"
    end

    def retry_options
      always_retryable = [Faraday::ConnectionFailed, Errno::ECONNREFUSED, ::Net::OpenTimeout]
      # Timeout::Error is the parent class of Net::ReadTimeout as well as Net::OpenTimeout
      idempotent_retryable = always_retryable + [::Timeout::Error, 'Error::TimeoutError']
      { max: configuration.retry_max, interval: configuration.retry_interval,
        # We only retry non-idempotent requests if we're sure the request was never received, not if we just couldn't
        # read the response in a reasonable time frame.
        retry_if: lambda do |_env, exception|
          always_retryable.any? { |ex_class| exception.is_a?(ex_class) }
        end,
        interval_randomness: configuration.retry_randomness,
        backoff_factor: configuration.retry_backoff_factor,
        exceptions: idempotent_retryable
      }
    end
  end
end
