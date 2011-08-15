class UserRolePermit < CanTango::RolePermit
  def initialize ability
    super
  end

  protected

  def static_rules
    author_of Article do |author|
      author.can :write
    end

    can :read, Article
    can :edit, Article
    cannot :create, Article
  end
end

