class AddNewStuff < ActiveRecord::Migration
  def change
    add_column :tasks, :date, :date
  end
end
