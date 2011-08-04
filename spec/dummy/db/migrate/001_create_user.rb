class CreateUser < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.string  :name
      t.string  :user_name
      t.string  :email
      t.string  :role
      t.string  :role_groups
      t.timestamps
    end
  end

  def self.down
    drop_table :users
  end
end
