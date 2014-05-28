class AddTimeAgreementToPrivateLessons < ActiveRecord::Migration
  def change
    add_column :private_lessons, :meeting_time_agreement, :text
  end
end
