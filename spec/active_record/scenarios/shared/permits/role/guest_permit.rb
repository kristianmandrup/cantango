class GuestRolePermit < CanTango::RolePermit
  def initialize ability
    super
  end

  protected

  def static_rules
    can :read, [Comment, Post, Article]
    can :create, Article
 
    # licenses :user_admin, :blogging
    
    # Guest must have an id
    #owns(user, Comment)
    
    # a user can manage comments he/she created
    # can :manage, Comment do |comment|
    #   (comment.try(:user)  == current_user) || (comment.try(:author) == current_user)
    # end            
    
    # can :create, Comment
  end  
end


