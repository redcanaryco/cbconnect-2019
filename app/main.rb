require_relative 'playbooks/basic_response_simple'

# we want simpler code by calling `.delay` on methods
Sidekiq::Extensions.enable_delay!

# and nicer logging
class SidekiqLogger < Sidekiq::Logging::Pretty
  def call(severity, time, program_name, message)
    "#{time.utc.iso8601(3)} #{Thread.current[:sidekiq_context]&.last&.split(' ')&.last} #{severity}: #{message}\n"
  end
end
Sidekiq.logger.formatter = SidekiqLogger.new

# Clear our job queue since this isn't a production thing
Sidekiq::Queue.new.clear
puts "#{Sidekiq::Queue.new.count} jobs"

#
# Run our playbook!
#
Playbooks::BasicResponseSimple.new.run!


