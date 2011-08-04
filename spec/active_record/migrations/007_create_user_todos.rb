class CreateUserTodos < ActiveRecord::Migration
  def self.up
    create_table :user_todos do |t|
      t.integer :user_id
      t.integer :todo_id
      t.timestamps
    end
  end

  def self.down
    drop_table :user_todos
  end
end
