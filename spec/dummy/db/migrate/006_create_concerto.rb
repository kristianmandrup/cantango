class CreateConcerto < ActiveRecord::Migration
  def self.up
    create_table :concertos do |t|
      t.integer   :user_id
      t.string    :title
      t.string    :body
      t.timestamps
    end
  end

  def self.down
    drop_table :concertos
  end
end
