class CreatePost < ActiveRecord::Migration
  def self.up
    create_table :posts do |t|
      t.integer   :author_id
      t.string    :title
      t.string    :body
      t.timestamps
    end
  end

  def self.down
    drop_table :posts
  end
end
