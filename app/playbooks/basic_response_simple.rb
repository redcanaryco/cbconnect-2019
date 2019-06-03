require 'sidekiq/api'
require_relative '../alert_receiver'
require_relative '../actions/find_endpoint'
require_relative '../actions/enrich_process_with_prevalence_info'
require_relative '../actions/find_process_by_network_connection'
require_relative '../actions/remediate_process'
require_relative '../actions/isolate_endpoint'

module Playbooks
  class BasicResponseSimple
    def run!
      puts "Starting playbook BasicResponseSimple"
      AlertReceiver.new.get_alerts.each do |alert|
        puts "- Processing alert #{alert['id']}"
        self.class.delay.step0_parse_alert(alert: alert)
      end
    end

    def self.step0_parse_alert(alert:)
      puts "- Step0"
      alert_source_hostname = alert['incidents'].first['description']['src_host_reverse']
      alert_ip_connection = {
          'src_ip' => alert['incidents'].first['description']['src_host'],
          'dest_ip' => alert['incidents'].first['description']['dst_host'],
          'dest_port' => alert['incidents'].first['description']['dst_port'],
      }

      delay.step1_find_endpoint source_hostname: alert_source_hostname, alert_ip_connection: alert_ip_connection
    end

    def self.step1_find_endpoint(source_hostname:, alert_ip_connection:)
      puts "- Step1"
      endpoint_info = Actions::FindEndpoint.new.call hostname: source_hostname

      delay.step2_find_process endpoint_info: endpoint_info,
                               src_ip: alert_ip_connection['src_ip'],
                               dest_ip: alert_ip_connection['dest_ip'],
                               dest_port: alert_ip_connection['dest_port']
    end

    def self.step2_find_process(endpoint_info:, src_ip:, dest_ip:, dest_port:)
      puts "- Step2"
      process_infos = Actions::FindProcessByNetworkConnection.new.call sensor_id: endpoint_info['id'],
                                                                       destination_ip: dest_ip,
                                                                       destination_port: dest_port

      process_infos.each do |process_info|
        delay.step3_enrich_process endpoint_info: endpoint_info, process_info: process_info
      end
    end

    def self.step3_enrich_process(endpoint_info:, process_info:)
      puts "- Step3"
      process_info = Actions::EnrichProcessWithPrevalenceInfo.new.call process_info: process_info,
                                                                       endpoint_info: endpoint_info

      delay.step4_isolate_and_remediate process_info: process_info, endpoint_info: endpoint_info
    end

    def self.step4_isolate_and_remediate(endpoint_info:, process_info:)
      puts "- Step4"
      endpoint_os = endpoint_info['os_environment_display_string'].to_s.downcase
      endpoint_type = if endpoint_os.include?('server') || (endpoint_os.include?('linux') && !endpoint_os.include?('desktop'))
                        'server'
                      else
                        'workstation'
                      end

      case endpoint_type
      when 'server'
        Actions::RemediateProcess.new.call process_pid: process_info['process_pid'],
                                           process_md5: process_info['process_md5'],
                                           sensor_id: endpoint_info['id']

      when 'workstation'
        Actions::IsolateEndpoint.new.call sensor_id: endpoint_info['id']

        Actions::RemediateProcess.new.call process_pid: process_info['process_pid'],
                                           process_md5: process_info['process_md5'],
                                           sensor_id: endpoint_info['id']

      else
        raise "Unknown endpoint_type=#{endpoint_type}"
      end

    end
  end
end

