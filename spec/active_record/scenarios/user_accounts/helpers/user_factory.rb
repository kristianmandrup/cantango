module UserFactory 
  def create_user role = :user
    # ||= here is important!
    @user ||= user_class(role).create(:name => "Kristian") 
  end

  def create_user_account user, role = :user
    user.active_account = account_class(role).create :role => role, :user => user
    user.active_account
  end

  def user_class role
    "#{role.to_s.camelize}".constantize
  end

  def account_class role
    "#{role.to_s.camelize}Account".constantize
  end
end
