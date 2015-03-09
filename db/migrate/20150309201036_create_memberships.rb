class CreateMemberships < ActiveRecord::Migration
  def change
    create_table :memberships do |t|
      t.integer :user_id
      t.integer :project_id
      t.belongs_to :user, index: true
      t.belongs_to :project, index: true
    end
    add_foreign_key :memberships, :users
    add_foreign_key :memberships, :projects
  end
end
