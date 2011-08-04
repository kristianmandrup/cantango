class AccountsController < ApplicationController
  before_filter :authenticate_user!

  expose(:accounts) { Account.all }
  expose(:account)
  
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

