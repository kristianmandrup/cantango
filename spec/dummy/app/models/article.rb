class Article < ActiveRecord::Base
  belongs_to :author, :foreign_key => 'user_id', :class_name => "User"

  has_friendly_id :title
end

