class Concerto < ActiveRecord::Base
	extend FriendlyId
	
  belongs_to :author, :foreign_key => 'user_id', :class_name => "User"

  friendly_id :title
end

