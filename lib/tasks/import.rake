require 'csv'

namespace :db do
  desc 'Import customer data to database'
  task import: :environment do
    print '.'
  end
end
