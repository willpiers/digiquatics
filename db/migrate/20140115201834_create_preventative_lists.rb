class CreatePreventativeLists < ActiveRecord::Migration
  def change
    create_table :preventative_lists do |t|
      t.string :name
      t.string :type

      t.timestamps
    end
  end
end
