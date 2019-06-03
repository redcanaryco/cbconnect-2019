#! /usr/bin/env ruby
AlertReceiver.new.when_alert_received do |alert|

  alert_process_name = extract_process_name_from_alert(alert)
  alert_hostname = extract_hostname_from_alert(alert)

  process_info = Actions::FindProcess.call process_name: alert_process_name, hostname: alert_hostname

  endpoint_info = Actions::FindEndpoint.call hostname: process_info['hostname']

  process_info = Actions::EnrichProcessWithPrevalenceInfo.call process_info: process_info

  endpoint_os = endpoint_info['os_environment_display_string'].to_s.downcase
  endpoint_type = if endpoint_os.include?('server') || (endpoint_os.include?('linux') && !endpoint_os.include?('desktop'))
                    'server'
                  else
                    'workstation'
                  end

  case endpoint_type
  when 'server'
    Actions::RemediateProcess.call process_name: process_info['process_name'], sensor_id: endpoint_info['id']

  when 'workstations'
    Actions::IsolateEndpoint.call sensor_id: endpoint_info['id']

    Actions::RemediateProcess.call process_name: process_info['process_name'], sensor_id: endpoint_info['id']
  end
end


