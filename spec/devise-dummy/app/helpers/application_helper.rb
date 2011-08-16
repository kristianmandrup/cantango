module ApplicationHelper
  def delete_user_path user
    user_path user, :method => 'delete'
  end

  def delete_post_path post
    post_path post, :method => 'delete'
  end
end
