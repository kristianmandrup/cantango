class SessionsController < ApplicationController
  [:user, :guest, :admin].each do |role|
    class_eval %{
      def login_#{role}
        session[:current_#{role}] = User.find params[:id]
        render :nothing => true
      end

      def logout_#{role}
        session[:current_#{role}] = nil
        render :nothing => true
      end
    }
  end
end

