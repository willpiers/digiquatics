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

# Upgrading BinStubs
bundle config --delete bin    # Turn off Bundler's stub generator
rake rails:update:bin         # Use the new Rails 4 executables
git add bin                   # Add bin/ to source control

# Virtual Server Setup

IP Address: `198.199.105.193`
Username: `root`
Password: `@ffektive!`

log into root user:
`ssh root@digiquatics.com` password is: `@ffektive!`

log into your own user account:
`ssh deployer@digiquatics.com` password is: `@ffektive!`

add new user:
`adduser deployer`
fill in info
`adduser deployer sudo`

Use the following command to continuously monitor the log output:
`tail -f /home/unicorn/log/unicorn.log`

Doing anything new, restart servers:
`service unicorn restart`
`service nginx restart`

Use `ssh-copy-id` instead of passwords, more secure:
`brew install ssh-copy-id`
`ssh-copy-id deployer@digiquatics.com`

Install Git:
`sudo apt-get install`

Install MySQL:
`sudo apt-get install mysql-server mysql-client libmysqlclient-dev`

Kill nginx process:
`sudo fuser -k 80/tcp`




Update packages on Ubuntu OS
`sudo apt-get update`

Install packages for use later:
`sudo apt-get -y install curl git-core python-software-properties`

Refer to Ubuntu PPA [http://wiki.nginx.org/Install#Ubuntu_PPA](http://wiki.nginx.org/Install#Ubuntu_PP)
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

ssh -A josh@digiquatics.com
git ls-remote git@github.com:duffcodester/digiquatics.git

me@localhost $ ssh root@remote
# Capistrano will use /var/www/....... where ... is the value set in
# :application, you can override this by setting the ':deploy_to' variable
root@remote $ deploy_to=/var/www/digiquatics
root@remote $ mkdir -p ${deploy_to}
root@remote $ chown josh:josh ${deploy_to}
root@remote $ umask 0002
root@remote $ chmod g+s ${deploy_to}
root@remote $ mkdir ${deploy_to}/{releases,shared}

cap production git:check

Create file:

```
# lib/capistrano/tasks/agent_forwarding.cap

desc "Check if agent forwarding is working"
task :forwarding do
  on roles(:all) do |h|
    if test("env | grep SSH_AUTH_SOCK")
      info "Agent forwarding is up to #{h}"
    else
      error "Agent forwarding is NOT up to #{h}"
    end
  end
end
```

`cap production forwarding` should return:

```
DEBUG [5820424c] Running /usr/bin/env [ ! -d ~/.rbenv/versions/2.0.0-p247 ] on digiquatics.com
DEBUG [5820424c] Command: [ ! -d ~/.rbenv/versions/2.0.0-p247 ]
DEBUG [5820424c] Finished in 1.191 seconds with exit status 1 (failed).
DEBUG [2c042b04] Running /usr/bin/env env | grep SSH_AUTH_SOCK on digiquatics.com
DEBUG [2c042b04] Command: env | grep SSH_AUTH_SOCK
DEBUG [2c042b04]  SSH_AUTH_SOCK=/tmp/ssh-l7DBCwrxNn/agent.12124
DEBUG [2c042b04] Finished in 0.215 seconds with exit status 0 (successful).
INFO Agent forwarding is up to digiquatics.com
```

Comment out these two lines in Capfile:

```
#require 'capistrano/rails/assets'
#require 'capistrano/rails/migrations'
```

Make sure database.yml file is ignored in git

Create directory `config` in `/var/www/digiquatics/shared`

Create new file called `database.yml` in `/var/www/digiquatics/shared/config`

```
production:
  adapter: mysql2
  encoding: utf8
  reconnect: false
  database: digiquatics_production
  pool: 5
  username: root
  password:
  socket: /tmp/mysql.sock
```

Remove Nginx default page:

```
sudo rm /etc/nginx/sites-enabled/default
```

Restart Nginx:

```
sudo service nginx restart
```

Make Unicorn run properly when Nginx starts:

```
sudo update-rc.d unicorn_blog defaults
```

After rebuild by Josh Duffy 1/26/2014:
Ubuntu 10.04.4 LTS
apt-get update
apt-get -y install curl git-core python-software-properties
add-apt-repository ppa:nginx/stable
apt-get update
apt-get -y install nginx
service nginx start

Install MySQL:
apt-get -y install mysql-server mysql-client libmysqlclient-dev

MySQL root user: Password: @ffektive!

mysql -u root -p
# create database digiquatics_production;
# grant all on digiquatics_production.* to digiquatics@localhost identified by '@ffektive!';
# exit

Node.JS
add-apt-repository ppa:chris-lea/node.js
apt-get -y update
apt-get -y install nodejs

Add another user: deployer
adduser deployer --ingroup sudo
Password: @ffektive!

su deployer
cd ~
curl -L https://raw.github.com/fesplugas/rbenv-installer/master/bin/rbenv-installer | bash

Add to .bashrc file using vi:

```
if [ -d $HOME/.rbenv ]; then
  export PATH="$HOME/.rbenv/bin:$PATH"
  eval "$(rbenv init -)"
fi
```
above:

```
# If not running interactively, don't do anything
[ -z "$PS1" ] && return
```
Reload .bashrc
. ~/.bashrc

rbenv install 2.0.0-p247
rbenv global 2.0.0-p247
ruby -v

gem install bundler --no-ri --no-rdoc
rbenv rehash
bundle -v

ssh git@github.com
