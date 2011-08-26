class AdminAccount
  attr_accessor :user, :roles, :role_groups

  def initialize user, options = {}
    @user = user
    @roles = options[:roles]
    @role_groups = options[:role_groups]
  end

  def has_role? name
    true
  end

  def roles_list
    roles
  end

  def role_groups_list
    role_groups
  end
end

