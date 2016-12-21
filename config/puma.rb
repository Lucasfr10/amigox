# Change to match your CPU core counttrue
workers 1

# Min and Max threads per worker
threads 1, 6
preload_app!
app_dir = File.expand_path(File.dirname(__FILE__)) + "/.."
shared_dir = "#{app_dir}"

# Default to production
rails_env = ENV['RAILS_ENV'] || "development"
environment rails_env

# Set up socket location
bind "unix:/tmp/amigox.sock"
bind "tcp://127.0.0.1:3000"

# Logging
stdout_redirect "#{shared_dir}/log/puma.log", "#{shared_dir}/log/puma.log", true

# Set master PID and state locations
#pidfile "#{shared_dir}/pids/puma.pid"
#state_path "#{shared_dir}/pids/puma.state"
activate_control_app

on_worker_boot do
  require "active_record"
  ActiveRecord::Base.connection.disconnect! rescue ActiveRecord::ConnectionNotEstablished
  ActiveRecord::Base.establish_connection(YAML.load_file("#{app_dir}/config/database.yml")[rails_env])
end
