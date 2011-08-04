module ApplicationHelper
  def current_user
    session[:current_user] ||= User.create!(:name => "Stanislaw", :role => 'user')
  end

  def current_guest
    session[:current_guest] ||= User.create!(:name => "Stanislaw guest", :role => 'guest')
  end

  def current_admin
    session[:current_admin] ||= User.create!(:name => "Stanislaw admin", :role => 'admin')
  end

  def current_user_account
    session[:current_user_account] ||= Account.create!(:name => "Stanislaw", :role => 'user', :user => current_user )
  end

  def current_guest_account
    session[:current_guest_account] ||= Account.create!(:name => "Stanislaw guest", :role => 'guest', :user => current_guest )
  end

  def current_admin_account
    session[:current_admin_account] ||= Account.create!(:name => "Stanislaw admin", :role => 'admin', :user => current_admin )
  end

  [:user, :guest, :admin].each do |role|
    class_eval %{
      def current_#{role}= user
        session[:current_#{role}] = user
      end

      def current_#{role}_account= account
        session[:current_#{role}_account] = account
      end
    }
  end
end
