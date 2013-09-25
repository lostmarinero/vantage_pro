class ChangeCreatedAtToInteger < ActiveRecord::Migration
  def up
    change_table :images do |t|
      t.change :taken_at, :integer
    end
  end

  def down
    change_table :images do |t|
      t.change :taken_at, :date
    end
  end
end
