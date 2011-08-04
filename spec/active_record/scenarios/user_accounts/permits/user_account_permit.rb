module UserAccountPermits
  class UserRolePermit < CanTango::RolePermit
    def initialize(ability, options = {})
      super
    end

    def static_rules
      cannot :manage, User

      can :read, Comment
      can :read, Post
      can :read, Article

      author_of(Article, :scope => :account) do |author|
        author.can :manage
      end

      author_of(Post, :scope => :account) do |author|
        author.can :manage
      end
      
      author_of(Comment, :scope => :account) do |author|
        author.can :manage
      end

     can :manage, user_account.user
   
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
