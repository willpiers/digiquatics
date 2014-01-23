# Digiquatics

## Database Setup
- download MySQL from [http://dev.mysql.com/downloads/mysql/](http://dev.mysql.com/downloads/mysql/)
- install both `.pkg` files from the `.dmg` file
- open `MySQL.prefPane` and start the server
- add

```
# Rails MySQL
MYSQL=/usr/local/mysql/bin
export PATH=$PATH:$MYSQL
export DYLD_LIBRARY_PATH=/usr/local/mysql/lib:$DYLD_LIBRARY_PATH
```
to your `.zshrc` or `.bashrc` file
- run `rake db:create`
- run `rake db:reset`
- run `rake db:populate`
- run `rake db:test:prepare`

# Virtual Server Setup

IP Address: 198.199.105.193
Username: root
Password: aqejxrjbkica

log into root user:
`ssh root@198.199.105.193` password is: `aqejxrjbkica`

log into your own user account:
`ssh <username>@198.199.105.193`

add new user:
`adduser <username>`
fill in info
`adduser <username> sudo`

Update packages on Ubuntu OS
`sudo apt-get update`

Install packages for use later:
`sudo apt-get -y install curl git-core python-software-properties`

Create apt repo for Nginx:
`sudo add-apt-repository ppa:nginx/stable`

Apt-Update:
`sudo apt-get update`

Install Nginx:
`sudo apt-get -y install nginx`

Start Nginx:
`sudo service nginx start`

Check server in browser:
[http://198.199.105.193](http://198.199.105.193)

Install MySQL:
`sudo apt-get -y install mysql-server mysql-client libmysqlclient-dev`
root password: @ffektive!

Enter MySQL:
`mysql -u root -p`
enter MySQL root password: @ffektive!

Create Production Database:
`create database diquatics_production;`

Grant user privileges to production database:
`grant all on digiquatcs_production.* to digiquatics@localhost identified by '@ffektive!';`

Exit MySQL:
`exit`

Install rbenv:
`sudo apt-get install rbenv`

Install build-essential package:
`sudo apt-get install build-essential`

Install ruby-build:
`sudo apt-get install ruby-build`

Install ruby using rbenv:
`rbenv install 2.0.0-p247`

Add this to `.bashrc`:

```
# rbenv ruby setup
export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"
```

Run this bullshit:
`rbenv rehash`

Check ruby version:
`ruby -v`

Install bundler and check version:
`gem install bundler --no-ri --no-rdoc && bundle -v`

Uncomment these in the Gemfile:

``` ruby
# Use unicorn as the app server
gem 'unicorn'

# Deploy with Capistrano
gem 'capistrano'
```

Install Capistrano:
`cap install`

Adjust deploy.rb file:

``` ruby
set :application, 'digiquatics'
set :repo_url, 'https://github.com/duffcodester/digiquatics.git'

# Default branch is :master
# ask :branch, proc { `git rev-parse --abbrev-ref HEAD`.chomp }

# Default deploy_to directory is /var/www/my_app
set :deploy_to, '/var/www/digiquatics'
```

Adjust production.rb file:

``` ruby
role :app, %w{198.199.105.193}
role :web, %w{198.199.105.193}
role :db,  %w{198.199.105.193}
```

Create `nginx.conf` and change stuff

Run `ssh-add -L` on local machine to view full ssh key

Login to remote server using your own user:
ssh josh@198.199.105.193

create new file in ~/.ssh/authorized_keys and add full ssh key, save, exit

```
cd ~
chmod 700 .ssh
cdmod 600 .ssh/authorized_keys
```

If it works try:

```
ssh josh@198.199.105.193 'hostname; uptime'
```

And you should get:

AquaticsApp
 23:53:17 up 10 days, 11:03,  0 users,  load average: 0.00, 0.01, 0.05

Create the directories in var/www/digiquatics:

```
~/var: mkdir www
~/var/www: mkdir digiquatics
~/var/www/digiquatics: mkdir releases
~/var/www/digiquatics: mkdir shared
```

Check directory structure on remote server:
ssh josh@198.199.105.193 'ls -lR /var/www/digiquatics'

/var/www/digiquatics:
total 8
drwxr-xr-x 2 root root 4096 Jan 23 00:01 releases
drwxr-xr-x 2 root root 4096 Jan 23 00:01 shared

/var/www/digiquatics/releases:
total 0

/var/www/digiquatics/shared:
total 0

Add File to lib/capistrano/tasks called 'access_check.cap':

```
desc "Check that we can access everything"
task :check_write_permissions do
  on roles(:all) do |host|
    if test("[ -w #{fetch(:deploy_to)} ]")
      info "#{fetch(:deploy_to)} is writable on #{host}"
    else
      error "#{fetch(:deploy_to)} is not writable on #{host}"
    end
  end
end
```

Add `gem 'capistrano-rbenv', github: "capistrano/rbenv"` to Gemfile

Add the following to the correct files:

```
# Capfile
require 'capistrano/rbenv'


# config/deploy.rb
set :rbenv_type, :user # or :system, depends on your rbenv setup
set :rbenv_ruby, '2.0.0-p247'
set :rbenv_prefix, "RBENV_ROOT=#{fetch(:rbenv_path)} RBENV_VERSION=#{fetch(:rbenv_ruby)} #{fetch(:rbenv_path)}/bin/rbenv exec"
set :rbenv_map_bins, %w{rake gem bundle ruby rails}
set :rbenv_roles, :all # default value
```
