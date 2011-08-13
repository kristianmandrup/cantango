require 'active_record/spec_helper'
CanTango.config.categories.register 'articles' => [Post, Article]

class EditorRolePermit < CanTango::RolePermit
  def initialize ability
    super
  end

  protected 

  def static_rules
    # uses default user_id
    #owns(user, Comment)

    can :read, Comment
    can :read, category(:articles)
    #author_of(Article, :scope => :account) do |author|
    #  author.can :manage
    #end

    #author_of(Post, :scope => :account) do |author|
    #  author.can :manage
    #end

    #author_of(Comment, :scope => :account) do |author|
    #  author.can :manage
    #end

    #author_of(Article).can :manage
    #author_of(Post).can :manage
    #author_of(Comment).can :manage
    can :write, :all
    #writer_of(Post).can :manage

    # a user can manage comments he/she created
    # can :manage, Comment do |comment|
    #   comment.try(:user) == user
    # end

    # can :create, Comment
  end 
end
