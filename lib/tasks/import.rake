require Rails.root.join('lib/modules/importer')

USER_DATA_FILE = 'db/data/lakewood/lakewood_user_import.csv'
CERT_DATA_FILE = 'db/data/lakewood/lakewood_certification_import.csv'

namespace :db do
  desc 'Import customer data to database'
  task import: :environment do
    Importer.import(user_data_file: Rails.root.join(USER_DATA_FILE),
                    cert_data_file: Rails.root.join(CERT_DATA_FILE))
  end
end
