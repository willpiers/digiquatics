listen "198.199.105.193:8080"
worker_processes 2
user "rails"
working_directory "/home/rails"
pid "/home/unicorn/pids/unicorn.pid"
stderr_path "/home/unicorn/log/unicorn.log"
stdout_path "/home/unicorn/log/unicorn.log"
timeout 30
