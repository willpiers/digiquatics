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

Add this to Capfile:

``` ruby
load 'deploy'
# Uncomment if you are using Rails' asset pipeline
load 'deploy/assets'
Dir['vendor/gems/*/recipes/*.rb','vendor/plugins/*/recipes/*.rb'].each { |plugin| load(plugin) }
load 'config/deploy' # remove this line to skip loading any of the default tasks
```

Change `deploy.rb` and create `nginx.conf` and change stuff

Run:
`rake assets:precompile`
