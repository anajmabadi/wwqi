listen "/tmp/wwqi.sock"
pid "tmp/pids/unicorn.pid"
stdout_path "log/unicorn.log"
stderr_path "log/unicorn_errors.log"

preload_app true
after_fork do |server, worker|
end
