module Actions
  class RemediateProcess
    def call(process_pid:, process_md5:, sensor_id:)
      puts "  ** RemediateProcess"

      puts "    - terminating process_pid=#{process_pid} on sensor_id=#{sensor_id}"
      if ENV['DEMO_MODE']
        # do nothing in demo
      else
        # TODO real implemenatation here via CbLR
      end

      puts "    - banning md5=#{process_md5}"
      if ENV['DEMO_MODE']
        # do nothing in demo
      else
        # TODO real implemenatation here via Cb
      end
    end
  end
end

