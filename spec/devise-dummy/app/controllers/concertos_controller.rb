class ConcertosController < ApplicationController
  # requires that a User is logged in
  # before_filter :authenticate_user!

  expose(:concertos) { Concerto.all }
  expose(:concerto)
  
  def index
  end

  def guest
  end

  def admin
  end

  def admin_account
  end

  def show
  end

  def new
  end

  def create
    if concerto.save
      redirect_to concerto, :notice => "Successfully created concerto."
    else
      render :new
    end
  end

  def edit
  end
  
  def update
    if concerto.update_attributes(params[:concerto])
      redirect_to concerto, :notice => "Successfully updated concerto."
    else
      render :edit
    end
  end
  
  def destroy
    concerto.destroy
    redirect_to concertos_url, :notice => "Successfully destroyed concerto."
  end
end
