class ChangeCreatedAtToInteger < ActiveRecord::Migration
  def change
    change_table :images do |t|
      t.change :taken_at, :datetime
    end
    add_index :images, :taken_at
  end
end
