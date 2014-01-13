class AddAccountIdToCertifications < ActiveRecord::Migration
  def change
    add_column :certifications, :account_id, :integer
  end
end
