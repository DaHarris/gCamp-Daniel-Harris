class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.string :text
      t.timestamps null: false
      t.belongs_to :user, index: true
      t.belongs_to :task, index: true
    end
  end
end
