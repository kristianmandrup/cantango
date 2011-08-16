module SimpleRoles
  def self.included(base)
    base.send :include, InstanceMethods
    base.extend ClassMethods
  end

  module ClassMethods
    def is_role_in_group?(role, group)
      raise "No group #{group} defined in User model" if !role_groups.has_key?(group)
      role_groups[group].include?(role)
    end

    def role_groups
      {:bloggers => [:editor]}
    end

    def roles
      [:guest, :user, :admin, :editor]
    end
  end

  module InstanceMethods

    attr_accessor :role_groups_list

    def has_role? role
      roles_list.include? role
    end

    def has_any_role? roles
      roles.include?(role.to_sym)
    end

    def roles_list
      role.to_s.scan(/\w+/).map{|r| r.to_sym}
    end

    def is_in_group? group
      role_groups_list.include? group
    end
    alias_method :in_role_group?, :is_in_group?

    def role_groups_list
      return role_groups.scan(/\w+/).map(&:to_sym) if respond_to?(:role_groups) && !role_groups.nil?
      @role_groups_list || [] #[:bloggers]
    end
  end
end

