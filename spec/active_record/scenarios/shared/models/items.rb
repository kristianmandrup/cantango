class Comment < ActiveRecord::Base
  belongs_to :author, :foreign_key => "user_id", :class_name => "User"
end

class Post < ActiveRecord::Base
  belongs_to :author, :foreign_key => 'user_id', :class_name => "User"
end

class Article < ActiveRecord::Base
  belongs_to :author, :foreign_key => 'user_id', :class_name => "User"
end


# Models for licenses testing:
class Song < ActiveRecord::Base
end

class Tune < ActiveRecord::Base
end

class Concerto < ActiveRecord::Base
end

class Improvisation < ActiveRecord::Base
end

