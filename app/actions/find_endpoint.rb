module Actions
  #
  # Finds an endpoint by hostname
  #
  class FindEndpoint
    def call(hostname:)
      puts "  ** FindEndpoint hostname=#{hostname}"

      if ENV['DEMO_MODE']
        # Sample response
        {
            "systemvolume_total_size" => "64422408192",
            "os_environment_display_string" => "Windows 7 Enterprise Edition, 32-bit",
            "shard_id" => 0,
            "clock_delta" => "0",
            "supports_cblr" => false,
            "sensor_uptime" => "4999",
            "last_update" => "2015-03-24 03:33:26.486905+00:00",
            "physical_memory_size" => "2146951168",
            "build_id" => 9,
            "uptime" => "30053",
            "is_isolating" => false,
            "event_log_flush_time" => nil,
            "computer_dns_name" => "WIN-ASDFASDF",
            "id" => 123,
            "power_state" => 2,
            "network_isolation_enabled" => false,
            "uninstalled" => nil,
            "systemvolume_free_size" => "44780228608",
            "status" => "Offline",
            "num_eventlog_bytes" => "103318",
            "sensor_health_message" => "Healthy",
            "build_version_string" => "004.002.005.50223",
            "computer_sid" => "S-1-5-21-2863734082-2406061759-2883063887",
            "next_checkin_time" => "2015-03-24 03:33:54.418068+00:00",
            "node_id" => 0,
            "cookie" => 1440121551,
            "computer_name" => "WIN-ASDFASDF",
            "license_expiration" => "1990-01-01 00:00:00+00:00",
            "supports_isolation" => false,
            "parity_host_id" => "0",
            "network_adapters" => "192.168.77.133,000c29cd72d4|",
            "sensor_health_status" => 100,
            "registration_time" => "2015-02-24 17:30:54.151931+00:00",
            "restart_queued" => false,
            "notes" => nil,
            "num_storefiles_bytes" => "124559219",
            "os_environment_id" => 4,
            "boot_id" => "1",
            "last_checkin_time" => "2015-03-24 03:33:24.445883+00:00",
            "group_id" => 1,
            "display" => true,
            "uninstall" => false
        }

      else
        # TODO implement via Cb query
      end
    end
  end
end

