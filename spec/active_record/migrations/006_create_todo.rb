class CreateTodo < ActiveRecord::Migration
  def self.up
    create_table :todos do |t|
      t.string    :body      
      t.timestamps
    end
  end

  def self.down
    drop_table :todos
  end
end
