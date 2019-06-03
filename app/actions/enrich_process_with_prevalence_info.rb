module Actions
  #
  # Enriches information about a process with information about how prevalent
  # that process is within this endpoint, organization, and the world.
  #
  class EnrichProcessWithPrevalenceInfo

    def call(process_info:, endpoint_info:)
      puts "  ** EnrichProcessWithPrevalenceInfo"

      # To simulate an external service failure, comment this in:
      # raise "External service is offline"

      if ENV['DEMO_MODE']
        # For this example, we'll just return our process info with some fake prevalence info.
        # - how often has this binary run on this endpoint?
        # - how often has this binary run in this organization?
        # - how often has this binary run in the world?
        process_info.merge prevalence: {
            executions_on_this_endpoint: 95,
            pct_endpoints_in_this_organization: 20.5,
            pct_endpoints_global: 2.3,
        }
      else
        # TODO implement via external service
      end
    end

  end
end

