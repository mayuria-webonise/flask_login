# config valid only for current version of Capistrano
lock '3.6.1'

set :application, 'login_flask'
set :repo_url, 'git@github.com:mayuria-webonise/flask_login.git'

set :branch,"master"
# Default branch is :master
# ask :branch, `git rev-parse --abbrev-ref HEAD`.chomp

# Default deploy_to directory is /var/www/my_app_name
set :deploy_to, "$HOME/deployed/#{fetch(:application)}"

# Default value for :scm is :git
set :scm, :git

# Default value for :format is :airbrussh.
# set :format, :airbrussh

# You can configure the Airbrussh format using :format_options.
# These are the defaults.
# set :format_options, command_output: true, log_file: 'log/capistrano.log', color: :auto, truncate: :auto

# Default value for :pty is false
# set :pty, true

# Default value for :linked_files is []
# append :linked_files, 'config/database.yml', 'config/secrets.yml'

# Default value for linked_dirs is []
# append :linked_dirs, 'log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'public/system'

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for keep_releases is 5
# set :keep_releases, 5
namespace :deploy do
	desc "Build Docker Images"
	task :docker_build do
		on roles(:app) do
			execute "cd #{release_path} && docker build -t #{fetch(:application)} ."
		end
	end

  	task :docker_run do
		on roles(:app) do
    		execute  "docker run --name=#{fetch(:application)} -td -p 5000:5000 #{fetch(:application)}"
  		end
  	end

	after:publishing, 'deploy:docker_build'
  	after:publishing, 'deploy:docker_run'
end