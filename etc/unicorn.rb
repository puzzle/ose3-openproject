app_dir = "/opt/app-root/src"

working_directory app_dir

pid "/tmp/unicorn.pid"

worker_processes 3
listen "/tmp/unicorn.sock", :backlog => 64
listen 8080, :tcp_nopush => true
timeout 30
