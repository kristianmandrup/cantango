class CreatePermissions < ActiveRecord::Migration
  def change
    create_table :permissions do |t|
      t.integer :user_id,    :thing_id
      t.string  :thing_type, :action
      t.timestamps
    end
  end
end

