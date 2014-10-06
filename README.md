
# DigiQuatics
[![Stories in Ready](https://badge.waffle.io/affektive/digiquatics.png?label=ready&title=Ready)](https://waffle.io/affektive/digiquatics)
[![Code Climate](https://codeclimate.com/github/affektive/digiquatics/badges/gpa.svg)](https://codeclimate.com/github/affektive/digiquatics)
[![Dependency Status](https://gemnasium.com/763d7e339248d2a0442ae161a7fe4c2b.svg)](https://gemnasium.com/duffcodester/digiquatics)
[ ![Codeship Status for affektive/digiquatics](https://codeship.io/projects/5d448710-ff39-0131-8ce1-4af98b35db61/status)](https://codeship.io/projects/29689)

[![Throughput Graph](https://graphs.waffle.io/affektive/digiquatics/throughput.svg)](https://waffle.io/affektive/digiquatics/metrics)

## Breakman (Security Auditing)
`breakman`

## Line Count
`find . -name '*.rb' | xargs wc -l`

## Database Setup
- download MySQL from [http://dev.mysql.com/downloads/mysql/](http://dev.mysql.com/downloads/mysql/)
- install both `.pkg` files from the `.dmg` file
- open `MySQL.prefPane` and start the server
- add

## Feature Toggles
create feature toggle file
``` bash
subl ~/feature_toggles.yml
```

add feature toggles, leave out or set to false for false, comma separarted
string of `account_id`'s to enable for accounts
``` yaml
maintenance: true
private_lessons: true
chemicals: '1'
attendance: false
shift_reports: false
scheduling: '1,2'
```

to use feature toggle
``` erb
<% FeatureToggle.scheduling? current_user %>
  <!-- scheduling stuff -->
<% end %>
```

remove this change
