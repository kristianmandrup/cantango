class UserRolePermit < CanTango::RolePermit
  def initialize ability
    super
  end

  protected

  def static_rules
    
    cannot :manage, User

    can :read, Comment
    can :read, any(/Post/)
    can :read, Article do |article|
    end

    can :write, any(/Article/)

    # Following will just return empty array of targets:
    # can :write, []
    can :write, any(/Unable to constantize/)

    # Todo.new.author - is attribute
    author_of(Article, Post, Comment) do |author|
      author.can :manage
    end

    # Todo.new.authors is Array
    author_of(Todo) do |author|
      author.can :write
    end

    # # can :manage, :all    
    # scope :account do |account|
    #   account.author_of(Article) do |author|
    #     author.can :manage
    #     author.cannot :delete
    #   end          
    #     
    #   account.writer_of(Post).can :manage
    # end
    # 
    # scope :user do |user|      
    #   user.writer_of(Comment).can :manage
    # end

    licenses :musicians
  end  
end
