class UsersController < ApplicationController
  before_filter :authenticate_user!

  expose(:users) { User.all }
  expose(:user)

  def index
  end

  def admin
  end

  def guest
  end

  def admin_account
  end

  def show
  end

  def new
  end
end

