class Todo < ActiveRecord::Base
  has_many :user_todos
  has_many :authors, :through => :user_todos, :source => :author
end
