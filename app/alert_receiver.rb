class AlertReceiver
  #
  # Pretend service that gets alerts from an external service - a Canary.tools device in this example
  #
  def get_alerts
    puts "Waiting for alerts"
    3.times do
      puts '.'
      sleep 1
    end

    puts "Got an alert!"
    JSON.parse(<<~EOF)
      [
        {
          "id": "incident:smbfileopen:7bce0c1dd1b011b7244fa668:192.168.1.240:1542249069",
          "incidents": [
              {
                  "description": {
                      "description": "Shared File Opened",
                      "dst_host": "192.168.1.64",
                      "dst_port": "445",
                      "local_time": "2018-11-15 02:31:08",
                      "logtype": "5000",
                      "mac_address": "",
                      "name": "SRV01",
                      "node_id": "0000000033b6b464",
                      "notified": "False",
                      "src_host": "192.168.1.240",
                      "src_host_reverse": "WIN-ASDFASDF",
                      "src_port": "-1"
                  },
                  "id": "incident:smbfileopen:7bce0c1dd1b011b7244fa668:192.168.1.240:1542249069",
                  "summary": "Shared File Opened",
                  "updated": "Thu, 15 Nov 2018 02:31:09 GMT",
                  "updated_id": 186,
                  "updated_std": "2018-11-15 02:31:09 UTC+0000"
              }
          ]
        }
      ]
    EOF
  end
end