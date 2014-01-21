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
