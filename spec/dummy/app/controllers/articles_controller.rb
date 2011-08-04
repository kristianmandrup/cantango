class ArticlesController < ApplicationController
  expose(:articles) { Article.all }
  expose(:article)
  
  def index
  end

  def admin
    user = User.create! :name => 'stanislaw', :role => 'user', :email => 'stanislaw@mail.ru'
    admin_user = User.create! :name => 'administrator', :role => 'admin', :email => 'admin@mail.ru'

    # Note: this is recommended approach
    # admin_user.masquerade_as user

    # Note: this requires gem 'friendly-id' or similar!
    admin_user.masquerade_as 'stanislaw'
    session[:current_admin] = admin_user
  end

  def guest
  end

  def admin_account
  end

  def show
  end

  def new
  end

  def create
    if article.save
      redirect_to article, :notice => "Successfully created article."
    else
      render :new
    end
  end

  def edit
  end
  
  def update
    if article.update_attributes(params[:article])
      redirect_to article, :notice => "Successfully updated article."
    else
      render :edit
    end
  end
  
  def destroy
    article.destroy
    redirect_to articles_url, :notice => "Successfully destroyed article."
  end
end
