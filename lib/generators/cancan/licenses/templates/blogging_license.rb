class BloggingLicense < License::Base
  def initialize name
    super
  end
  
  def enforce!
    can(:read, Blog)
    can(:create, Post)
    owns(user, Post)
  end
end

