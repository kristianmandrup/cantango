module CurrentUsers
  def current_user
    @current_user ||= ::User.new 'stan', 'stan@mail.ru', :role => 'user'
  end

  def current_admin
    @current_admin ||= ::User.new 'admin', 'admin@mail.ru', :role => 'admin'
  end
end

