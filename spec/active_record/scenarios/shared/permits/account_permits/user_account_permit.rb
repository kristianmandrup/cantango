module UserAccountPermits
  class UserRolePermit < CanTango::RolePermit
    def initialize(ability)
      super
    end

    protected

    # should take user and options args here ???
    def static_rules
      cannot :manage, User

      can :read, Comment
      can :read, any(/Post/)
      can :read, Article

      can :write, any(/Article/)

      author_of(Article) do |author|
        author.can :manage
      end

      author_of(Post) do |author|
        author.can :manage
      end

      author_of(Comment) do |author|
        author.can :manage
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
    end  
  end
end
