module AdminAccountPermits
  class AdminRolePermit < CanTango::RolePermit
    def initialize(ability)
      super
    end

    protected

    def static_rules
      author_of(Article) do |author|
        author.can :manage
      end
      can :manage, :all

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
