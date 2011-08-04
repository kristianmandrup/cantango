class UserAdminLicense < License::Base
  def initialize name
    super
  end

  def enforce!
    can(:manage, User)
  end
end

