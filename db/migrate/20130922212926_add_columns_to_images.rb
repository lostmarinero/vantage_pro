class AddColumnsToImages < ActiveRecord::Migration
  def change
    add_column :images, :user_name, :string
    add_column :images, :taken_at, :date
  end
end
