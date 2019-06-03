module Actions
  #
  # Isolates the endpoint with the given sensor_id
  #
  class IsolateEndpoint
    def call(sensor_id:)
      puts "  ** IsolateEndpoint isolating sensor_id=#{sensor_id}"

      if ENV['DEMO_MODE']
        # do nothing in demo

      else
        # get current information about the sensor
        url = "#{cb_url}/api/v1/sensor/#{sensor_id}"
        response = RestClient::Resource.new(url, headers: {'X-Auth-Token' => cb_auth_token, accept: :json}).get
        sensor_info = JSON.parse response.body

        # set isolation flag to true
        sensor_info['network_isolation_enabled'] = true

        # apply it
        RestClient::Resource.new(url, headers: {'X-Auth-Token' => cb_auth_token, accept: :json}).
            put(sensor_info.to_json, content_type: :json)

      end
    end
  end
end

