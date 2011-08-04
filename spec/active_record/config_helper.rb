# These modules can be included into a describe block (see troles)

# shared_examples_for "Common API for multiple roles" do
#   include UserSetup 
#     
#   it_behaves_like "Common Write API for multiple roles" do
#     define_users
#   end  
# end
# 
# shared_examples_for "Common Core API" do
#   # Core API
#   specify             { lambda { user.role_field }.should raise_error } # no, role_field is a class method    
#   specify             { User.role_field.should_not be_nil } # yes, role_field is a class method    
# 
#   subject { user }
#     its(:role_list)     { should include(:user) }
#     its(:roles)         { should be_a Troles::Operations }
# 
#   specify             { user.static_roles?.should be_false }
#   specify             { User.static_roles?.should be_false }  
#   
#   # TODO: Add examples with other users?
# end

# def define_users
#   let(:no_roles_user) { create_no_roles_user  }
#   let(:user)          { create_user  }
#   let(:admin_user)    { create_admin_user  }
# end  
# 
# shared_examples_for "Troles API" do
#   include UserSetup 
#      
#   it_behaves_like "Troles Core API" do
#     define_users
#   end  


module Config
  def self.create_role name
    Role.create(:name => name.to_s)
  end

  def self.create_rolegroup name, options = {}
    RoleGroup.create(:name => name.to_s, :roles => options[:roles])
  end

  def self.add_rolegroups hash
    hash.each_pair {|name, roles| create_rolegroup(name, :roles => roles) }
  end


  def self.add_roles *names
    names.flatten.each {|n| create_role(n) }
  end
end



module Config
  module Basic
    def basic_config context
      send :"#{context}_config"
    end

    def guest_config
      @guest    = User.new(1, :guest)
      @ability  = Permits::Ability.new @guest 
      @comment  = Comment.new(1)
      @post     = Post.new(1)
    end

    def admin_config
      @admin = User.new(1, :admin, 'kristian')
      @ability = Permits::Ability.new(@admin)
    end

    def admin_account_config
      @user = User.new(1, :admin, 'kristian')
      @admin = AdminAccount.new(@user.id, :admin)
      @ability = Permits::Ability.new(@admin)
    end
  end

  module Ownership
    def two_users_config 
      @editor         = User.create(:name => "Kristian", :role => "editor")
      @other_guy      = User.create(:name => "Random dude", :role => "admin")
      @ability        = Permits::Ability.new(@editor)

      @own_post       = Post.create(:writer => @editor.id)
      @other_post     = Post.create(:writer => @other_guy.id)      
    end

    def editor_config
      @editor         = User.create(:name => "Kristian", :role => "editor")
      @other_guy      = User.create(:name => "Random dude", :role => "admin")

      @ability        = Permits::Ability.new(@editor)

      @own_comment    = Comment.create(:user_id => @editor.id)
      @other_comment  = Comment.create(:user_id => @other_guy.id)      
      # @post     = Post.create(:writer => @editor.id)
      # @article  = Article.create(:author => @editor.id)
    end  
  end
end