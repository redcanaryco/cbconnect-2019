module Actions
  #
  # Finds processes on a given endpoint that made a network connection to the given ip/port
  #
  class FindProcessByNetworkConnection
    def call(sensor_id:, destination_ip:, destination_port:)
      puts "  ** FindProcessByNetworkConnection sensor_id=#{sensor_id} destination_ip=#{destination_ip} destination_port=#{destination_port}"

      # Sample response
      if ENV['DEMO_MODE']
        [
            {
                "process_md5" => "7c1a00c878eb89cb03be9b8133141b1b",
                "sensor_id" => 123,
                "parent_unique_id" => "000000c8-0000-0001-01d2-8aeb8340bed8",
                "cmdline" => "chrome.exe",
                "id" => "000000c8-0000-0176-01d2-8aeb865ca82a",
                "parent_name" => "launchd",
                "parent_md5" => "000000000000000000000000000000",
                "group" => "Default Group",
                "hostname" => "WIN-ASDFASDF",
                "last_update" => "2017-02-19T20:05:32.471Z",
                "start" => "2017-02-19T20:05:32.333Z",
                "comms_ip" => 1135380847,
                "interface_ip" => -1062731301,
                "process_pid" => 374,
                "username" => "chris",
                "process_name" => "AntiSleepHelper",
                "path" => "/Applications/AntiSleep.app/Contents/Library/LoginItems/AntiSleepHelper.app/Contents/MacOS/AntiSleepHelper",
                "parent_pid" => 1,
                "host_type" => "workstation",
                "os_type" => "osx",
                "unique_id" => "000000c8-0000-0176-01d2-8aeb865ca82a"
            }
        ]

      else
        query = {
            'q' => ["ipaddr:#{destination_ip} ipport:#{destination_port} sensor_id:#{sensor_id}"],

            'sort' => 'last_update desc',
            'facet' => ['false', 'false'],
            'rows' => 10,
            'cb.urlver' => ['1'],
            'start' => 0,
            'timeAllowed' => 60000
        }

        url = "#{cb_url}/api/v1/process"
        response = RestClient::Resource.new(url, headers: {'X-Auth-Token' => cb_auth_token, accept: :json}).
            post query.to_json, content_type: :json

        JSON.parse response.body
      end
    end
  end
end