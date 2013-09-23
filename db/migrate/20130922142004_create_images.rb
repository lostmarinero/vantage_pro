class CreateImages < ActiveRecord::Migration
  def change
    create_table :images do |t|
      t.string :name
      t.integer :event_id
      t.string :url
      t.timestamps
    end
  end
end
