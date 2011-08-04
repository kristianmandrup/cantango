class PostsController < ApplicationController
  expose(:posts) { Post.all }
  expose(:post)
  
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

  def create
    if post.save
      redirect_to post, :notice => "Successfully created post."
    else
      render :new
    end
  end

  def edit
  end
  
  def update
    if post.update_attributes(params[:post])
      redirect_to post, :notice => "Successfully updated post."
    else
      render :edit
    end
  end
  
  def destroy
    post.destroy
    redirect_to posts_url, :notice => "Successfully destroyed post."
  end
end

